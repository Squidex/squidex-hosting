#!/bin/bash
cd /tmp

echo "STEP 1: Install Docker"

# Download script
curl -fsSL https://get.docker.com -o get-docker.sh

# Allow unset variables again
set +u

# Execute script
(. ./get-docker.sh)

echo "STEP 2: Install Docker-Compose"

# Install compose
curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Apply executable permissions to the binary
sudo chmod +x /usr/local/bin/docker-compose