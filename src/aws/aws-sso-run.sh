#!/bin/bash
# Helper script to refresh AWS SSO session if required.
#
# Usage:
#   ./aws-sso-run -- <command>
#   AWS_DEFAULT_PROFILE=kolatr-dev ./aws-run -- <command>
#
# If the AWS SSO session is expired, it will refresh the session.
SSO_ACCOUNT=$(aws sts get-caller-identity --query "Account")
if [ ${#SSO_ACCOUNT} -ne 14 ];  then 
    echo "Refreshing session"
    aws sso login
fi

# Call the supplied program
exec "$@"
