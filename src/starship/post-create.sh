#!/usr/bin/env bash
set -e

echo "eval \"$(starship init bash)\"" >> $HOME/.bashrc
echo "eval \"$(starship init zsh)\"" >> $HOME/.zshrc
