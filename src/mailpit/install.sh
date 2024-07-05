#!/bin/bash
set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

bash < <(curl -sL https://raw.githubusercontent.com/axllent/mailpit/develop/install.sh)

if [ "$AUTOSTART" = "true" ]; then
    install $(pwd)/entrypoint.sh /usr/local/bin/mailpit-entrypoint
fi
