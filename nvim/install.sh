#!/usr/bin/env bash

echo "Linking neovim..."
mkdir -p $XDG_CONFIG_HOME/nvim;
ln -sf $DOTFILES/nvim/init.lua $XDG_CONFIG_HOME/nvim/init.lua
ln -sf $DOTFILES/nvim/lua $XDG_CONFIG_HOME/nvim

echo "Installing neovim plugins..."
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
