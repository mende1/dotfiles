#!/bin/sh

if [ ! -d "$HOME/.dotfiles" ]; then
    echo "Installing Dotfiles from @mende1"
    git clone https://github.com/mende1/dotfiles.git "$HOME/.dotfiles"
    cd "$HOME/.dotfiles"
    ./install-dotfiles.sh
else
    echo "Dotfiles directory already exists. Please remove it, and running this script again."
fi