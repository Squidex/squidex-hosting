#!/bin/bash
################################################
## Build example snapshot for Vultr Marketplace
## Tested on Ubuntu 20.04
##
## Prerequisites
chmod +x /root/vultr-helper.sh
. /root/vultr-helper.sh
error_detect_on
install_cloud_init latest

################################################
## Install your app here.

################################################
## Prepare server snapshot for Marketplace
clean_system
