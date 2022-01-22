#!/usr/bin/env bash

# Install tmux plugin manager if doesn't exist
if [[ ! -d ~/.tmux/plugins/tpm ]]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo "Linking tmux..."
mkdir -p $XDG_CONFIG_HOME/tmux;
ln -sf $DOTFILES/tmux/tmux.conf $XDG_CONFIG_HOME/tmux/tmux.conf
