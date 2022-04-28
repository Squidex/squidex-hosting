#!/bin/bash
## Runs once-and-only-once at first boot per instance.
echo $(date -u) ": System provisioned." >> /var/log/per-instance.log

cd /home/

## Capture Marketplace Password Variables
SQUIDEX_DOMAIN=$(curl -H "METADATA-TOKEN: vultr" http://169.254.169.254/v1/internal/app-domain)
GITHUB_CLIENT_ID=$(curl -H "METADATA-TOKEN: vultr" http://169.254.169.254/v1/internal/app-github_id)
GITHUB_CLIENT_SECRET=$(curl -H "METADATA-TOKEN: vultr" http://169.254.169.254/v1/internal/app-github_secret)
GOOGLE_CLIENT_ID=$(curl -H "METADATA-TOKEN: vultr" http://169.254.169.254/v1/internal/app-google_id)
GOOGLE_CLIENT_SECRET=$(curl -H "METADATA-TOKEN: vultr" http://169.254.169.254/v1/internal/app-google_secret)
MICROSOFT_CLIENT_ID=$(curl -H "METADATA-TOKEN: vultr" http://169.254.169.254/v1/internal/app-ms_id)
MICROSOFT_CLIENT_SECRET=$(curl -H "METADATA-TOKEN: vultr" http://169.254.169.254/v1/internal/app-ms_secret)

file=".env"
[ -f $file ] && rm $file

echo "SQUIDEX_DOMAIN=$SQUIDEX_DOMAIN" >> .env
echo "SQUIDEX_ADMINEMAIL=" >> .env
echo "SQUIDEX_ADMINPASSWORD=" >> .env
echo "SQUIDEX_GITHUBCLIENT=$GITHUB_CLIENT_ID" >> .env
echo "SQUIDEX_GITHUBSECRET=$GITHUB_CLIENT_SECRET" >> .env
echo "SQUIDEX_GOOGLECLIENT=$GOOGLE_CLIENT_ID" >> .env
echo "SQUIDEX_GOOGLESECRET=$GOOGLE_CLIENT_SECRET" >> .env
echo "SQUIDEX_MICROSOFTCLIENT=$MICROSOFT_CLIENT_SECRET" >> .env
echo "SQUIDEX_MICROSOFTSECRET=$MICROSOFT_CLIENT_SECRET" >> .env
echo "UI__ONLYADMINSCANCREATEAPPS=true" >> .env

curl "https://raw.githubusercontent.com/Squidex/squidex-hosting/master/docker-compose/docker-compose.yml" -o docker-compose.yml

docker-compose up -d