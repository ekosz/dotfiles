#!/usr/bin/env bash

# Exit on errors
set -euo pipefail

# Parse command line options
ONLY=
POSITIONAL_ARGS=()
while [[ $# -gt 0 ]]; do
  case $1 in
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
if (( ${#POSITIONAL_ARGS[@]} )); then
  set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters
fi

# Make sure we're in _this_ directory
cd "$(dirname "${BASH_SOURCE}")";

# Load ENV variables
source ./zsh/zshenv

# If --only flag used, assume we want speed
if [[ ! -n $ONLY ]]; then
  # Get latest code first
  git pull origin master;
fi

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

if [[ ! -n $ONLY || $ONLY == "zsh" ]]; then
  ./zsh/install.sh
fi
if [[ ! -n $ONLY || $ONLY == "alacritty" ]]; then
  ./alacritty/install.sh
fi
if [[ ! -n $ONLY || $ONLY == "git" ]]; then
  ./git/install.sh
fi
if [[ ! -n $ONLY || $ONLY == "nvim" || $ONLY == "vim" ]]; then
  ./nvim/install.sh
fi
if [[ ! -n $ONLY || $ONLY == "skhd" ]]; then
  ./skhd/install.sh
fi
if [[ ! -n $ONLY || $ONLY == "tmux" ]]; then
  ./tmux/install.sh
fi
if [[ ! -n $ONLY || $ONLY == "yabai" ]]; then
  ./yabai/install.sh
fi
