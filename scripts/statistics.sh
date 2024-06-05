#!/bin/bash

# Install jq
apt-get install -y jq

ROOTDIR=$1

node /app/bin/contributors.js -f "$ROOTDIR/statistics_config.json" -o "$ROOTDIR/statistics.json"
