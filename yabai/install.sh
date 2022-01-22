#!/usr/bin/env bash

RESET=$'\e[0m'
# FG = 38, BG = 48
WHITE_BG=$'\e[48;5;255m'
BLACK_FG=$'\e[38;5;0m'

function highlight {
  printf "$WHITE_BG"
  printf "$BLACK_FG"
  printf "$1"
  printf "$RESET"
}

if ! [ -x "$(command -v yabai)" ]; then
  # Install dev version of yabai
  # https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(from-HEAD)
  echo "Installing yabai from HEAD"
  echo "This will require codesigning with a self-signed certificate, so we'll have to create one first"
  echo "Press any key to open the Keychain Access.app"
  read
  open -a "Keychain Access"
  echo "In its menu, navigate to $(highlight 'Keychain Access'), then $(highlight 'Certificate Assistance'), then click $(highlight 'Create a Certificate...'). This will open the $(highlight 'Certificate Assistant'). Choose these options:"
  echo ""
  echo "Name: $(highlight 'yabai-cert')"
  echo "Identity Type: $(highlight 'Self-Signed Root')"
  echo "Certificate Type: $(highlight 'Code Signing')"
  echo ""
  echo "Click $(highlight 'Create'), then $(highlight 'Continue') to create the certificate"
  echo ""
  echo "Press any key when completed"
  read
  brew install koekeishiya/formulae/yabai --HEAD
  codesign -fs 'yabai-cert' $(which yabai)
  echo "Open $(highlight 'System Preferences.app') and navigate to $(highlight 'Security & Privacy'), then $(highlight 'Privacy'), then $(highlight 'Accessibility'). Click the lock icon at the bottom and enter your password to allow changes to the list. Add $(highlight 'yabai') manually by using the $(highlight '+') labelled button. When installed using Homebrew, yabai will usually be at $(highlight "$HOMEBREW_PREFIX/bin/yabai"). Check the box next to $(highlight 'yabai') to allow accessibility permissions."
  echo ""
  echo "Press any key when completed"
  read
  sudo yabai --load-sa
fi

echo "Linking yabai..."
mkdir -p $XDG_CONFIG_HOME/yabai;
ln -sf $DOTFILES/yabai/yabairc $XDG_CONFIG_HOME/yabai/yabairc

brew services restart yabai
