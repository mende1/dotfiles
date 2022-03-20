#!/usr/bin/env bash

[ ! $ZDOTDIR ]  && mkdir $ZDOTDIR;

ln -sf $DOTFILES/zsh/zshenv $HOME/.zshenv
ln -sf $DOTFILES/zsh/.zshrc  $HOME/.zshrc
