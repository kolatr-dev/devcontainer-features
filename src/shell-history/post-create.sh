#! /usr/bin/bash
set -e

touch /commandhistory/.bash_history
touch /commandhistory/.zsh_history
echo "export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.bash_history" >> $HOME/.bashrc
echo "export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.zsh_history" >> $HOME/.zshrc
