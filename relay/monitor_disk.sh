#!/bin/bash

set -e
set -x

THRESHOLD=90
MOUNT_POINT="/"

# Get the current usage percentage (stripping the % sign)
CURRENT_USAGE=$(df "$MOUNT_POINT" | grep "$MOUNT_POINT" | awk '{print $5}' | sed 's/%//')

# Check if usage exceeds threshold
if [ "$CURRENT_USAGE" -gt "$THRESHOLD" ]; then
    echo "CRITICAL: Disk usage at ${CURRENT_USAGE}%. Stopping $CONTAINER_NAME to prevent disk overflow."
    
    # Stop the container
    cd /srv/mediamtx
    docker compose down
else
    echo "Disk usage is at ${CURRENT_USAGE}%. System healthy."
fi
