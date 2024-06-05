#!/bin/bash

ROOTDIR=$1

# Fetch the content from the URL
content=$(curl -s "https://raw.githubusercontent.com/Informatievlaanderen/data.vlaanderen.be-statistics/production/aggr.stat")

echo "$content"

echo "$ROOTDIR/statistics.json"

TOTAL_TERMS=$(echo "$content" | jq -r '.totalterms')

echo "$TOTAL_TERMS"

# Query certain keys and concatenate them into a JSON object
uniqueContributors=$(echo "$content" | jq -r '(.authors | tonumber) + (.editors | tonumber) + (.contributors | tonumber) + (.participants | tonumber)')
json=$(echo "$content" | jq -r --argjson uc "$uniqueContributors" '{uniqueContributors: $uc}')

uniqueAffiliations=$(echo "$content" | jq -r '.totalorganisations | tonumber')
json=$(echo "$json" | jq -r --argjson to "$uniqueAffiliations" '. + {totalOrganisations: $to}')

# Store the result in statistics.json
echo "$json" >"$ROOTDIR/statistics.json"
