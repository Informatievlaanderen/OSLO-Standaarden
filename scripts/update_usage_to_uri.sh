#!/bin/bash

# Check if jq is installed
if ! command -v jq &>/dev/null; then
    echo "Error: jq is required but not installed. Please install jq."
    exit 1
fi

# Path to the JSON file
JSON_FILE="standaardenregister.json"

# Create a working directory
WORK_DIR="../"
mkdir -p "$WORK_DIR"

echo "Starting to process repositories..."

# Loop through each item in the JSON array
jq -c '.[]' "$JSON_FILE" | while read -r item; do
    # Extract repository and configuration from JSON
    REPO_URL=$(echo "$item" | jq -r '.repository // empty')
    CONFIG_FILE=$(echo "$item" | jq -r '.configuration // empty')

    # Skip if repository or configuration is empty
    if [ -z "$REPO_URL" ] || [ -z "$CONFIG_FILE" ]; then
        continue
    fi

    # Extract repository name from URL
    REPO_NAME=$(basename "$REPO_URL")

    echo "Processing: $REPO_NAME with config: $CONFIG_FILE"

    # Clone the repository if it doesn't exist yet
    if [ ! -d "$WORK_DIR/$REPO_NAME" ]; then
        echo "Cloning $REPO_URL..."
        git clone "$REPO_URL" "$WORK_DIR/$REPO_NAME" || {
            echo "Failed to clone $REPO_URL. Skipping."
            continue
        }
    fi

    # Change to the repository directory
    cd "$WORK_DIR/$REPO_NAME" || {
        echo "Failed to change to directory. Skipping."
        continue
    }

    # Make sure we have the latest changes
    git fetch
    git pull

    # Check out the standaardenregister branch
    echo "Checking out standaardenregister branch..."
    git checkout standaardenregister || {
        echo "Failed to checkout standaardenregister branch. Skipping."
        cd - >/dev/null
        continue
    }

    # Full path to the configuration file
    CONFIG_PATH="$CONFIG_FILE"

    # Check if the configuration file exists
    if [ ! -f "$CONFIG_PATH" ]; then
        echo "Configuration file $CONFIG_PATH does not exist. Skipping."
        cd - >/dev/null
        continue
    fi

    # Get the current usage value
    CURRENT_USAGE=$(jq -r '.usage // ""' "$CONFIG_PATH")
    echo "Current usage: $CURRENT_USAGE"

    # Skip if usage is already a URI
    if [[ "$CURRENT_USAGE" == "https://data.vlaanderen.be/id/concept/StandaardGebruik/"* ]]; then
        echo "Usage is already a URI. Skipping."
        cd - >/dev/null
        continue
    fi

    # Convert to lowercase and remove spaces for comparison
    NORMALIZED_USAGE=$(echo "$CURRENT_USAGE" | tr '[:upper:]' '[:lower:]' | tr -d ' ')

    # Determine the new usage URI based on the current usage
    NEW_USAGE=""
    if [[ "$NORMALIZED_USAGE" == *"aanbevolen"* ]]; then
        NEW_USAGE="https://data.vlaanderen.be/id/concept/StandaardGebruik/Aanbevolen"
        echo "Mapping to Aanbevolen"
    elif [[ "$NORMALIZED_USAGE" == *"verplicht"* ]]; then
        NEW_USAGE="https://data.vlaanderen.be/id/concept/StandaardGebruik/Verplicht"
        echo "Mapping to Verplicht"
    elif [[ "$NORMALIZED_USAGE" == *"pastoeofleguit"* ]]; then
        NEW_USAGE="https://data.vlaanderen.be/id/concept/StandaardGebruik/PasToeOfLegUit"
        echo "Mapping to PasToeOfLegUit"
    else
        echo "Could not determine mapping for usage: $CURRENT_USAGE. Skipping."
        cd - >/dev/null
        continue
    fi

    # Update the usage field in the configuration file
    # echo "Updating usage in $CONFIG_PATH to $NEW_USAGE..."
    if jq --arg new_usage "$NEW_USAGE" '.usage = $new_usage' "$CONFIG_PATH" >"$CONFIG_PATH.tmp"; then
        mv "$CONFIG_PATH.tmp" "$CONFIG_PATH"

        # Commit the changes
        echo "Committing changes..."
        git config user.name "oslo-support@vlaanderen.be"
        git config user.email "oslo@vlaanderen.be"
        git add "$CONFIG_PATH"
        git commit -m "Update usage to URI format"

        # Push changes (uncomment when ready to push)
        git push origin standaardenregister

        echo "Successfully updated $CONFIG_PATH"
    else
        echo "Failed to update $CONFIG_PATH"
    fi

    # Return to the original directory
    cd - >/dev/null

    echo "Completed processing $REPO_NAME"
    echo "---------------------------------"
done

echo "All repositories processed."
