#!/usr/bin/env bash
set -e

if [ ! "$MAILPIT_AUTOSTART" = "false" ]; then
    echo "Running mailpit"
    mailpit > /var/log/mailpit.log
    echo "mailpit complete"
fi

exec "$@"