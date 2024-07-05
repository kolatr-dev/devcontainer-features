#!/bin/bash

set -e

if [ -f /var/log/mailpit.log ]; then
    echo "💥 Error: log file exists"
    exit 1
else
    echo "✅ log file does not exist"
    exit 0
fi
