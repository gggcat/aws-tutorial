#!/bin/bash

DOMAIN_NAME=$1

DNS_HOSTED_ZONE_ID=$(aws route53 list-hosted-zones --query "HostedZones[?Name==\`${DOMAIN_NAME}.\`].Id" | grep -o -E "[A-Z0-9]+")
DNS_HOSTED_ZONE_ID=$(aws route53 list-hosted-zones --query "HostedZones[?Name==\`${DOMAIN_NAME}.\`].Id" | jq -r '.[]')

# HOSTED_ZONE_IDを使ってレコードの値がacm-validations.awsを含むレコードを抽出する
DNS_VALIDATION_RECORDSET=$(aws route53 list-resource-record-sets --hosted-zone-id ${DNS_HOSTED_ZONE_ID} | jq '.ResourceRecordSets[] | select (.ResourceRecords[].Value | contains("acm-validations.aws")) | .Name')

echo ${DNS_VALIDATION_RECORDSET}