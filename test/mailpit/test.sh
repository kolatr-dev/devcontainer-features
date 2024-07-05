#!/bin/bash

set -e

source dev-container-features-test-lib

check "mailpit installed" mailpit --help

reportResults