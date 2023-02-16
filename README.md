# My Arch Linux + KDE Plasma Installation Step by Step





### General Settings

- [ ] Double Click to open files and folders (System Settings > Workspace Behavior > General Behavior > Selects them)

- [ ] 

  

### Install Yay

```bash
sudo pacman -S git base-devel
git clone https://aur.archlinux.org/yay.git /tmp/yay
cd /tmp/yay
makepkg -si
```



### Git Configuration and Clone dotfiles repository

```bash
yay -S git
git config --global user.name "Gustavo Mendel"
git config --global user.email "gustavo.mendel.br@gmail.com"
git clone https://github.com/mende1/dotfiles /tmp/dotfiles
```



### Install the fonts from dotfiles

```bash
cd /tmp/dotfiles/fonts
for zipfile in *.zip; do unzip "$zipfile" -d "${zipfile%.zip}"; rm "${zipfile}"; done
sudo cp -R * /usr/share/fonts
```



### Customizing Konsole KDE Terminal

##### Install Zsh

```bash
yay -S zsh
```

##### Install Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

##### Install Dracula Theme for Konsole (https://draculatheme.com/konsole)

 ```bash
 cp /tmp/dotfiles/Dracula.colorscheme ~/.local/share/konsole
 ```

Now, change the font of Konsole to "FiraCode NF 12pt" and theme for Dracula



### Install Spaceship

```bash
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
```

Now, change the theme section in your `.zshrc` to spaceship, like that: `ZSH_THEME="spaceship"`.

And add this to the end of the file to additional configurations of Spaceship:

```sh
SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  exec_time     # Execution time
  line_sep      # Line break
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
SPACESHIP_USER_SHOW=always
SPACESHIP_PROMPT_ADD_NEWLINE=false
```



### Install Zinit to add plugins of Oh My Zsh

Add this to the end of the file .zshrc

```bash
if [[ ! -f $HOME/.zi/bin/zi.zsh ]]; then
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f"
  command mkdir -p "$HOME/.zi" && command chmod g-rwX "$HOME/.zi"
  command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
source "$HOME/.zi/bin/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi
# examples here -> https://z.digitalclouds.dev/ecosystem/annexes
zicompinit # <- https://z.digitalclouds.dev/docs/guides/commands

zi light zdharma/fast-syntax-highlighting
zi light zsh-users/zsh-autosuggestions
zi light zsh-users/zsh-completions
```

