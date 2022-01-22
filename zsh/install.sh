#!/usr/bin/env zsh

# Exit on errors
set -euo pipefail

if [[ -z "${ZSH_CUSTOM:-}" ]]; then
  export ZSH_CUSTOM="$ZSH/custom"
fi

# Install oh-my-zsh if doesn't exist
if [[ ! -d ~/.oh-my-zsh ]]; then
  echo "Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
  echo "Installing zsh-autosuggestions plugin"
  git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
fi

if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]]; then
  echo "Installing zsh-syntax-highlighting plugin"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
fi

if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-z" ]]; then
  echo "Installing zsh-z plugin"
  git clone https://github.com/agkozak/zsh-z $ZSH_CUSTOM/plugins/zsh-z
fi

echo "Linking zsh..."
mkdir -p $ZDOTDIR;
ln -sf $DOTFILES/zsh/zshenv $HOME/.zshenv
ln -sf $DOTFILES/zsh/zprofile $ZDOTDIR/.zprofile
ln -sf $DOTFILES/zsh/zshrc $ZDOTDIR/.zshrc
source "$ZDOTDIR/.zshrc"
