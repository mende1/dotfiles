#!/bin/sh

git --version 2>&1 >/dev/null
GIT_IS_AVAILABLE=$?

if [ ! $GIT_IS_AVAILABLE -eq 0 ]; then
    echo "Git command not found, please install git and try the installation again."
    exit
fi

if [ ! -d "$HOME/.dotfiles" ]; then
    echo "Installing Dotfiles from @mende1"
    git clone --recurse-submodules https://github.com/mende1/dotfiles.git "$HOME/.dotfiles"
    cd "$HOME/.dotfiles"
    ./install-dotfiles.sh
else
    echo "Dotfiles directory already exists. Please remove it, and running this script again."
fi