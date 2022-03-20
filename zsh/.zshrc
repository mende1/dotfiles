#
#   Zsh dotfiles from @mende1
#


# P10K      ##########################################################
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $DOTFILES/powerlevel10k/powerlevel10k.zsh-theme

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# ASDF      ##########################################################
. $DOTFILES/asdf/asdf.sh

fpath=(${ASDF_DIR}/completions $fpath)
autoload -Uz compinit && compinit

export PATH="$PATH:$ASDF_DIR/installs/rust/stable/bin"


# ALIASES   ##########################################################
source $ZDOTDIR/aliases.zsh


# PLUGINS   ##########################################################
source $ZDOTDIR/plugins.zsh


# FUNCTIONS ##########################################################
source $ZDOTDIR/functions.zsh

