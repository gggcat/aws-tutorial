#!/usr/bin/env bash

usage() {
  echo "usage: dns-validation-del.sh <domain-name>"
}

domain_name="$1"

if [ -z "$domain_name" ]; then
  usage
  echo -en "\033[0;31m" # display red
  echo "Error: Provide a domain name."
  echo -en "\033[0m"
  exit 1
fi

hosted_zone_id=$(aws route53 list-hosted-zones \
--query "HostedZones[?Name==\`$domain_name.\`].Id" \
| grep -o -E "[A-Z0-9]+")


aws route53 change-resource-record-sets --hosted-zone-id $hosted_zone_id --change-batch file://dns-validation-del.json
