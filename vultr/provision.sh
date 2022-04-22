#!/bin/bash
## Runs once-and-only-once at first boot per instance.
echo $(date -u) ": System provisioned." >> /var/log/per-instance.log

## Capture Marketplace Password Variables
SQUIDEX_HOST=$(curl -H "METADATA-TOKEN: vultr" http://169.254.169.254/v1/internal/app-squidex_host)

file=".env"
[ -f $file ] && rm $file

echo "SQUIDEX_DOMAIN=$SQUIDEX_HOST" >> .env
echo "SQUIDEX_ADMINEMAIL=" >> .env
echo "SQUIDEX_ADMINPASSWORD=" >> .env
echo "UI__ONLYADMINSCANCREATEAPPS=true" >> .env

curl "https://raw.githubusercontent.com/Squidex/squidex-hosting/master/docker-compose/docker-compose.yml" - docker-compose.yml

docker-compose up -d