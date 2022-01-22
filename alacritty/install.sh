#!/usr/bin/env bash

echo "Linking alacritty..."
mkdir -p $XDG_CONFIG_HOME/alacritty;
ln -sf $DOTFILES/alacritty/alacritty.yml $XDG_CONFIG_HOME/alacritty/alacritty.yml
