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

DOTFILES="$HOME/.dotfiles"

echo 'Linking .zshrc file'
ln -sf "$DOTFILES/.zshrc" "$HOME/.zshrc" 

echo 'Linking vim config'
ln -sf "$DOTFILES/.vimrc" "$HOME/.vimrc"

# Git
echo 'Linking git config'
ln -sf "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig"

mkdir -p ~/.config/atuin

echo 'Linking starship config'
ln -sf "$DOTFILES/starship.toml" "$HOME/.config/starship.toml"

echo 'Linking atuin config'
ln -sf "$DOTFILES/atuin.config.toml" "$HOME/.config/atuin/config.toml"

echo 'Linking karabiner config'
ln -sf "$DOTFILES/karabiner.json" "$HOME/.config/karabiner/karabiner.json"

echo 'Starting ollama service'
brew services start ollama

echo 'Linking asdf config'
ln -sf "$DOTFILES/.asdfrc" "$HOME/.asdfrc"
echo 'Installing asdf base plugin'
asdf plugin add nodejs
asdf plugin add java
asdf plugin add golang
ln -sf "$DOTFILES/.tool-versions" "$HOME/.tool-versions"
asdf install

sudo ./sudo_install.sh
