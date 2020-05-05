#!/bin/bash

TARGET_GROUP_ARN=$(aws elbv2 describe-target-groups | jq -r '.TargetGroups[] | select (.TargetGroupName == "tutorial-nlb-ec2-tg") | .TargetGroupArn')

aws elbv2 describe-target-health --target-group-arn ${TARGET_GROUP_ARN}
