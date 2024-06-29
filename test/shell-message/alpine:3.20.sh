#!/bin/bash

set -e

source dev-container-features-test-lib

check "foo service check" fastfetch | grep 'foo'
check "bar service check" fastfetch | grep 'bar'

reportResults