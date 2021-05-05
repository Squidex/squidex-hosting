#!/bin/bash

# Prompt user to enter config.

echo "> This script will setup a basic configuration of Squidex"
echo "> using docker-compose that is suitable for the most use cases."
echo "> Please go to https://docs.squidex.io for advanced configuration."
echo
echo "> Please enter the host name. You need a public DNS entry,"
echo "> because Squidex will get a certificate using lets encrypt."
echo

read -p "Enter Host Name (required): " hostName
while [ -z "$hostName" ]; do
	read -p "Enter Host Name (required): " hostName
done

echo
echo "> You can also configure external authentication providers if you want."
echo "> If no external provider is configured you can later setup an account." 
echo

read -p "Enter Google Client ID (optional): " googleClientId
read -p "Enter Google Client Secret (optional): " googleSecret

read -p "Enter Github Client ID (optional): " githubClientId
read -p "Enter Github Client Secret (optional): " githubSecret

read -p "Enter Microsoft Client ID (optional): " microsoftClientId
read -p "Enter Microsoft Client Secret (optional)": microsoftSecret

echo
echo "SUMMARY"

echo "Hostname:        		   $hostName"
echo "Google Client ID:        $googleClientId"
echo "Google Client Secret:    $googleSecret" 
echo "Github Client ID:        $githubClientId" 
echo "Github Client Secret:    $githubSecret"
echo "Microsoft Client ID:     $microsoftClientId"
echo "Microsoft Client Secret: $microsoftSecret"

echo
echo "Waiting 10 seconds. You may press Ctrl+C now to abort this script."

file=".env"
[ -f $file ] && rm $file

echo "SQUIDEX_DOMAIN=$hostName" >> .env
echo "SQUIDEX_ADMINEMAIL=" >> .env
echo "SQUIDEX_ADMINPASSWORD=" >> .env
echo "SQUIDEX_GOOGLECLIENT=$googleClientId" >> .env
echo "SQUIDEX_GOOGLESECRET=$googleSecret" >> .env
echo "SQUIDEX_GITHUBCLIENT=$githubClientId" >> .env
echo "SQUIDEX_GITHUBSECRET=$githubSecret" >> .env
echo "SQUIDEX_MICROSOFTCLIENT=$microsoftClientId" >> .env
echo "SQUIDEX_MICROSOFTSECRET=$microsoftSecret" >> .env
echo "UI__ONLYADMINSCANCREATEAPPS=true" >> .env

( set -x; sleep 10 )

docker-compose up -d