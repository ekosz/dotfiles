#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
  if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    curl -o /tmp/brew-installer.sh -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
    bash /tmp/brew-installer.sh
    if [[ $? -eq 1 ]]; then
      echo "Brew install failed. Exiting..."
      exit 1
    fi
  fi

  echo "Installing Homebrew depencies..."
  brew bundle --no-lock

  echo "Syncing dot files..."
  rsync --exclude ".git/" \
    --exclude ".DS_Store" \
    --exclude ".osx" \
    --exclude "bootstrap.sh" \
    --exclude "README.md" \
    --exclude "Brewfile" \
    --exclude "Brewfile.lock.json" \
    -avh --no-perms . ~;

  echo "Installing neovim plugins..."
  nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
}

if [[ $1 == "--force" || $1 == "-f" ]]; then
  doIt;
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    doIt;
  fi;
fi;
unset doIt;
