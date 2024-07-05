#!/usr/bin/env bash
set -e

if [ ! "$MAILPIT_AUTOSTART" = "false" ]; then
    mailpit > /var/log/mailpit.log 2>&1 &
fi

exec "$@"