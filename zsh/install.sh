#!/usr/bin/env zsh

# Install oh-my-zsh if doesn't exist
if [[ ! -d ~/.oh-my-zsh ]]; then
  echo "Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "Linking zsh..."
mkdir -p $ZDOTDIR;
ln -sf $DOTFILES/zsh/zshenv $HOME/.zshenv
ln -sf $DOTFILES/zsh/zprofile $ZDOTDIR/.zprofile
ln -sf $DOTFILES/zsh/zshrc $ZDOTDIR/.zshrc
source "$ZDOTDIR/.zshrc"
