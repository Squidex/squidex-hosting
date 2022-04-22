#!/bin/bash
################################################
## Build example snapshot for Vultr Marketplace
## Tested on Debian 10
##
## Prerequisites
chmod +x /root/vultr-helper.sh
. /root/vultr-helper.sh
error_detect_on
install_cloud_init latest

################################################
## Install your app here.
flock /var/lib/apt/lists/lock-frontend

chmod +x /root/install-docker.sh
. /root/install-docker.sh

# Make the script executable.
chmod +x /var/lib/cloud/scripts/per-instance/provision.sh

################################################
## Prepare server snapshot for Marketplace
clean_system
