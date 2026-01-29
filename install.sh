#!/bin/zsh
# Exit on error
set -e

if [[ $(command -v brew) == "" ]]; then
  echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Updating Homebrew"
    brew update
fi

# Install homebrew dependencies
brew bundle install

# Install ohmyzsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing OhMyZsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Updating OhMyZsh"
  $ZSH/tools/upgrade.sh
fi

echo 'Linking .zshrc file'
ln -s ~/.zshrc .zshrc 

echo 'Linking vim config'
ln -s ~/.vimrc .vimrc

# Git
echo 'Linking git config'
ln -s ~/.gitconfig git/.gitconfig

mkdir -p ~/.config

echo 'Linking starship config'
ln -s ~/.config/starship.toml starship.toml

echo 'Linking atuin config'
ln -s ~/.config/atuin/config.toml atuin.config.toml

echo 'Linking asdf config'
ln -s ~/.asdfrc .asdfrc 

echo 'Starting ollama service'
brew services start ollama

sudo ./sudo_install.sh
