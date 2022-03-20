#!/usr/bin/env bash

git clone https://github.com/asdf-vm/asdf.git $DOTFILES/asdf --branch v0.9.0

. $DOTFILES/asdf/asdf.sh

asdf plugin add rust
asdf install rust 1.59.0