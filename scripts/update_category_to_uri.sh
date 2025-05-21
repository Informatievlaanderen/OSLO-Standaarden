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

    # Get the current category value
    CURRENT_CATEGORY=$(jq -r '.category // ""' "$CONFIG_PATH")
    echo "Current category: $CURRENT_CATEGORY"

    # Skip if category is already a URI
    if [[ "$CURRENT_CATEGORY" == "https://data.vlaanderen.be/id/concept/StandaardType/"* ]]; then
        echo "Category is already a URI. Skipping."
        cd - >/dev/null
        continue
    fi

    # Convert to lowercase and remove spaces for comparison
    NORMALIZED_CATEGORY=$(echo "$CURRENT_CATEGORY" | tr '[:upper:]' '[:lower:]' | tr -d ' ')

    # Determine the new category URI based on the current category
    NEW_CATEGORY=""
    if [[ "$NORMALIZED_CATEGORY" == *"applicatieprofiel"* ]]; then
        NEW_CATEGORY="https://data.vlaanderen.be/id/concept/StandaardType/Applicatieprofiel"
        echo "Mapping to Applicatieprofiel"
    elif [[ "$NORMALIZED_CATEGORY" == *"vocabularium"* ]]; then
        NEW_CATEGORY="https://data.vlaanderen.be/id/concept/StandaardType/Vocabularium"
        echo "Mapping to Vocabularium"
    elif [[ "$NORMALIZED_CATEGORY" == *"implementatiemodel"* ]]; then
        NEW_CATEGORY="https://data.vlaanderen.be/id/concept/StandaardType/Implementatiemodel"
        echo "Mapping to Implementatiemodel"
    elif [[ "$NORMALIZED_CATEGORY" == *"technischestandaard"* ]]; then
        NEW_CATEGORY="https://data.vlaanderen.be/id/concept/StandaardType/TechnischeStandaard"
        echo "Mapping to TechnischeStandaard"
    elif [[ "$NORMALIZED_CATEGORY" == *"organisatorischeinteroperabiliteit"* ]]; then
        NEW_CATEGORY="https://data.vlaanderen.be/id/concept/StandaardType/OrganisatorischeInteroperabiliteit"
        echo "Mapping to OrganisatorischeInteroperabiliteit"
    else
        echo "Could not determine mapping for category: $CURRENT_CATEGORY. Skipping."
        cd - >/dev/null
        continue
    fi

    # Update the category field in the configuration file
    echo "Updating category in $CONFIG_PATH to $NEW_CATEGORY..."
    if jq --arg new_category "$NEW_CATEGORY" '.category = $new_category' "$CONFIG_PATH" >"$CONFIG_PATH.tmp"; then
        mv "$CONFIG_PATH.tmp" "$CONFIG_PATH"

        # Commit the changes
        echo "Committing changes..."
        git config user.name "oslo-support@vlaanderen.be"
        git config user.email "oslo@vlaanderen.be"
        git add "$CONFIG_PATH"
        git commit -m "Update category to URI format"

        # Push changes
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
