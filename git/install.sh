#!/usr/bin/env bash

echo "Linking git..."
mkdir -p $XDG_CONFIG_HOME/git;
ln -sf $DOTFILES/git/config $XDG_CONFIG_HOME/git/config
ln -sf $DOTFILES/git/gitignore_global $XDG_CONFIG_HOME/git/gitignore_global
