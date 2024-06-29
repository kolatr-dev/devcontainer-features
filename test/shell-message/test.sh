#!/bin/bash

set -e

source dev-container-features-test-lib

check "validate system boots" fastfetch | grep 'tailscale'

reportResults