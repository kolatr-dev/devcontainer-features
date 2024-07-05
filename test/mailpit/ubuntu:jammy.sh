#!/bin/bash

set -e

if [ -f /var/log/mailpit.log ]; then
    echo "✅ log file exists"
    exit 0
else
    echo "💥 Error: log file does not exist"
    exit 1
fi
