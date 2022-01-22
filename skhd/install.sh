#!/usr/bin/env bash

echo "Linking skhd..."
mkdir -p $XDG_CONFIG_HOME/skhd;
ln -sf $DOTFILES/skhd/skhdrc $XDG_CONFIG_HOME/skhd/skhdrc
brew services restart skhd
