#!/bin/sh

AZ="$(curl -sL instance-data/latest/meta-data/placement/availability-zone)"
REGION="${AZ%?}"
INSTANCE_ID="$(curl -sL 169.254.169.254/latest/meta-data/instance-id)"

aws ec2 modify-instance-attribute --region $REGION --instance-id i-$INSTANCE_ID --no-source-dest-check
