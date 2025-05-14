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
    REPO_URL=$(echo "$item" | jq -r '.repository')
    CONFIG_FILE=$(echo "$item" | jq -r '.configuration')

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
    # Get the current status value
    CURRENT_STATUS=$(jq -r '.status // ""' "$CONFIG_PATH")
    echo "Current status: $CURRENT_STATUS"

    # Convert to lowercase and remove dashes for comparison
    NORMALIZED_STATUS=$(echo "$CURRENT_STATUS" | tr '[:upper:]' '[:lower:]' | tr -d '-')

    # Determine the new status URI based on the current status
    NEW_STATUS=""
    if [[ "$NORMALIZED_STATUS" == *"standaardinontwikkeling"* ]]; then
        NEW_STATUS="https://data.vlaanderen.be/id/concept/StandaardStatus/OntwerpStandaard"
        echo "Mapping to OntwerpStandaard"
    elif [[ "$NORMALIZED_STATUS" == *"kandidaatstandaard"* ]]; then
        NEW_STATUS="https://data.vlaanderen.be/id/concept/StandaardStatus/KandidaatStandaard"
        echo "Mapping to KandidaatStandaard"
    elif [[ "$NORMALIZED_STATUS" == *"erkendestandaard"* ]]; then
        NEW_STATUS="https://data.vlaanderen.be/id/concept/StandaardStatus/ErkendeStandaard"
        echo "Mapping to ErkendeStandaard"
    elif [[ "$NORMALIZED_STATUS" == *"herroepenstandaard"* ]]; then
        NEW_STATUS="https://data.vlaanderen.be/id/concept/StandaardStatus/HerroepenStandaard"
    fi

    # Update the status field in the configuration file
    echo "Updating status in $CONFIG_PATH to $NEW_STATUS..."
    if jq --arg new_status "$NEW_STATUS" '.status = $new_status' "$CONFIG_PATH" >"$CONFIG_PATH.tmp"; then
        mv "$CONFIG_PATH.tmp" "$CONFIG_PATH"

        # Commit the changes
        echo "Committing changes..."
        git config user.name "oslo-support@vlaanderen.be"
        git config user.email "oslo@vlaanderen.be"
        git add "$CONFIG_PATH"
        git commit -m "Update status to URI format"

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
