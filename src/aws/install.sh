#!/usr/bin/env bash

mkdir -p /opt/aws
cp config.ini /opt/aws/config
cp aws-run.sh /usr/local/bin/aws-sso-run
chmod +x /usr/local/bin/aws-sso-run
