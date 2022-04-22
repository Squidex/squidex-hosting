#!/bin/bash
################################################
## Build example snapshot for Vultr Marketplace
## Tested on Ubuntu 18.04
##
## Prerequisites
chmod +x /root/vultr-helper.sh
. /root/vultr-helper.sh
error_detect_on
install_cloud_init latest

################################################
## Install your app here.
wait_on_apt_lock

chmod +x /root/install-docker.sh
. /root/install-docker.sh

# Make the script executable.
chmod +x /var/lib/cloud/scripts/per-instance/provision.sh

################################################
## Prepare server snapshot for Marketplace
clean_system
