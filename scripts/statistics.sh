#!/bin/bash

ROOTDIR=$1

node /app/bin/contributors.js -f "$ROOTDIR/statistics_config.json" -o "$ROOTDIR/statistics.json"

# Fetch the content from the URL
content=$(curl -s "https://raw.githubusercontent.com/Informatievlaanderen/data.vlaanderen.be-statistics/production/aggr.stat")

echo "$content"

# Query certain keys and concatenate them into a JSON object
json=$(echo "$content" | jq -r '{uniqueContributors: (.authors | tonumber) + (.editors | tonumber) + (.contributors | tonumber) + (.participants | tonumber)}')
json=$(echo "$content" | jq -r '{: (totalorganisations | tonumber)}')

echo "$json"

# Store the result in statistics.json
echo "$json" >"$ROOTDIR/statistics.json"
