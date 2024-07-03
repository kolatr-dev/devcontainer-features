#!/bin/bash

set -e

# Add to shell profiles
echo 'if [ "$KOLATR_DISABLE_SHELL_MESSAGE" != "true" ]; then fastfetch; fi' >> ~/.bashrc
echo 'if [ "$KOLATR_DISABLE_SHELL_MESSAGE" != "true" ]; then fastfetch; fi' >> ~/.zshrc
echo 'if [ "$KOLATR_DISABLE_SHELL_MESSAGE" != "true" ]; then fastfetch; fi' >> ~/.profile
