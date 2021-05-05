#!/bin/bash
################################################
## Build example snapshot for Vultr Marketplace
## Tested on Ubuntu 20.04
################################################

######################
## Prerequisite steps
######################

## Update the server.
apt-get -y update
apt-get -y upgrade
apt-get -y autoremove
apt-get -y autoclean

#############################################
## Install Docker
#############################################
cd /tmp

echo "STEP 1: Install Docker"
# Download script
curl -fsSL https://get.docker.com -o get-docker.sh
# Execute script
(. ./get-docker.sh)

echo "STEP 2: Install Docker-Compose"
# Install compose
curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# Apply executable permissions to the binary
sudo chmod +x /usr/local/bin/docker-compose


#############################################
## Install vultr-support branch of cloud-init
#############################################
cd /tmp
wget https://ewr1.vultrobjects.com/cloud_init_beta/cloud-init_universal_latest.deb
wget https://ewr1.vultrobjects.com/cloud_init_beta/universal_latest_MD5
sleep 10
echo "Expected MD5SUM:"
cat /tmp/universal_latest_MD5
echo "Computed MD5SUM:"
echo "$(md5sum /tmp/cloud-init_universal_latest.deb)"
apt-get update -y
sleep 10

apt-get install -y /tmp/cloud-init_universal_latest.deb
sleep 10

## Create script folders for cloud-init
mkdir -p /var/lib/cloud/scripts/per-boot/

## Make a per-boot script.
cat << "EOFBOOT" > /var/lib/cloud/scripts/per-boot/setup.sh
#!/bin/bash
## Run on every boot.
echo $(date -u) ": System booted." >> /var/log/per-boot.log
EOFBOOT

# Make the scripts executable
chmod +x /var/lib/cloud/scripts/per-boot/setup.sh

##########################################
## Prepare server snapshot for Marketplace
##########################################

## Clean the temporary directories, SSH keys, logs, history, etc.
rm -rf /tmp/*
rm -rf /var/tmp/*
rm -f /root/.ssh/authorized_keys /etc/ssh/*key*
touch /etc/ssh/revoked_keys
chmod 600 /etc/ssh/revoked_keys

## Clean the logs.
find /var/log -mtime -1 -type f -exec truncate -s 0 {} \;
rm -rf /var/log/*.gz
rm -rf /var/log/*.[0-9]
rm -rf /var/log/*-????????
echo "" >/var/log/auth.log

## Clean old cloud-init information.
rm -rf /var/lib/cloud/instances/*

## Clean the session history.
history -c
cat /dev/null > /root/.bash_history
unset HISTFILE

## Update the mlocate database.
/usr/bin/updatedb

## Wipe random seed files.
rm -f /var/lib/systemd/random-seed

## Distributions that use systemd should wipe the machine identifier to prevent boot problems.
rm -f /etc/machine-id
touch /etc/machine-id

## Clear the login log history.
cat /dev/null > /var/log/lastlog
cat /dev/null > /var/log/wtmp

## Wipe unused disk space with zeros for security and compression.
echo "Clearing free disk space. This may take several minutes."
dd if=/dev/zero of=/zerofile status=progress
sync
rm /zerofile
sync
echo "Setup is complete. Begin snapshot process."