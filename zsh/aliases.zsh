# custom aliases

alias ls="exa --icons"
alias cat="bat"
alias z="cd ~/Zumtec"
alias b="cd ~/Zumtec/book-a-doctor-back-end"
alias update="sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y && asdf update && asdf plugin update --all"
alias sourcezsh="source $ZDOTDIR/.zshrc"

alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index