#!/bin/zsh

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Always show hidden files
defaults write http://com.apple.Finder AppleShowAllFiles true
# No accents when a char is pressed
defaults write -g ApplePressAndHoldEnabled -bool false
