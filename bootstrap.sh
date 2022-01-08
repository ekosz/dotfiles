#!/usr/bin/env bash

# Parse command line options
POSITIONAL_ARGS=()
while [[ $# -gt 0 ]]; do
  case $1 in
    -f|--force)
      FORCE=YES
      shift # past argument
      ;;
    -o|--only)
      ONLY="$2"
      shift # past argument
      shift # past value
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done
set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

# Make sure we're in _this_ directory
cd "$(dirname "${BASH_SOURCE}")";

# If --only flag used, assume we want speed
if [[ ! -n $ONLY ]]; then
  # Get latest code first
  git pull origin master;
fi

function install() {
  if [[ ! -n $ONLY || $ONLY == "brew" || $ONLY == "homebrew" ]]; then
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
  fi

  if [[ ! -n $ONLY || $ONLY == "files" || $ONLY == "dotfiles" || $ONLY == "f" || $ONLY == "config" ]]; then
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
  fi
}

if [[ $FORCE == "YES" ]]; then
  install;
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    install;
  fi;
fi;
unset install;
