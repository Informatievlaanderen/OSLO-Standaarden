#!/bin/bash

# Check if jq is installed
if ! command -v jq &>/dev/null; then
    echo "Error: jq is required but not installed. Please install jq."
    exit 1
fi

JSON_FILE="standaardenregister.json"
CSV_FILE="$(pwd)/scripts/titles_and_organizations.csv"
FALLBACK_DOMAIN="https://data.vlaanderen.be/id/concept/Domein/Onbekend"
WORK_DIR="../"
mkdir -p "$WORK_DIR"

echo "Starting to process repositories..."

jq -c '.[]' "$JSON_FILE" | while read -r item; do
    REPO_URL=$(echo "$item" | jq -r '.repository // empty')
    CONFIG_FILE=$(echo "$item" | jq -r '.configuration // empty')

    if [ -z "$REPO_URL" ] || [ -z "$CONFIG_FILE" ]; then
        continue
    fi

    REPO_NAME=$(basename "$REPO_URL")
    echo "Processing: $REPO_NAME with config: $CONFIG_FILE"

    if [ ! -d "$WORK_DIR/$REPO_NAME" ]; then
        echo "Cloning $REPO_URL..."
        git clone "$REPO_URL" "$WORK_DIR/$REPO_NAME" || {
            echo "Failed to clone $REPO_URL. Skipping."
            continue
        }
    fi

    cd "$WORK_DIR/$REPO_NAME" || {
        echo "Failed to change to directory. Skipping."
        continue
    }

    git fetch
    git pull

    echo "Checking out standaardenregister branch..."
    git checkout standaardenregister || {
        echo "Failed to checkout standaardenregister branch. Skipping."
        cd - >/dev/null
        continue
    }

    CONFIG_PATH="$CONFIG_FILE"

    if [ ! -f "$CONFIG_PATH" ]; then
        echo "Configuration file $CONFIG_PATH does not exist. Skipping."
        cd - >/dev/null
        continue
    fi

    CONFIG_TITLE=$(jq -r '.title // empty' "$CONFIG_PATH")
    DOMAIN=$(awk -F';' -v title="$CONFIG_TITLE" 'NR>1 && $1==title {print $5}' "$CSV_FILE")

    # Remove carriage return if present
    DOMAIN=$(echo "$DOMAIN" | tr -d '\r')

    if [ -z "$DOMAIN" ]; then
        DOMAIN="$FALLBACK_DOMAIN"
    fi

    # Update the domain field in the configuration file
    if jq --arg domain "$DOMAIN" '.domain = $domain' "$CONFIG_PATH" >"$CONFIG_PATH.tmp"; then
        mv "$CONFIG_PATH.tmp" "$CONFIG_PATH"

        # Commit and push changes
        git config user.name "oslo-support@vlaanderen.be"
        git config user.email "oslo@vlaanderen.be"
        git add "$CONFIG_PATH"
        git commit -m "Add or update domain key in configuration"
        git push origin standaardenregister

        echo "Successfully updated and pushed $CONFIG_PATH"
    else
        echo "Failed to update $CONFIG_PATH"
    fi

    echo "---------------------------------"
    echo "Title: $CONFIG_TITLE"
    echo "Domain: $DOMAIN"
    echo "---------------------------------"

    cd - >/dev/null
    echo "Completed processing $REPO_NAME"
    echo "---------------------------------"
done

echo