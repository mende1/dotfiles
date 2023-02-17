# My Arch Linux + KDE Plasma Installation Step by Step





### General Settings

- Double Click to open files and folders (System Settings > Workspace Behavior > General Behavior > Selects them)

- In Workspace Behavior > Virtual Desktops, add more 3 rows of virtual desktop, resulting in 4.



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
git clone git@github.com:mende1/dotfiles.git /tmp/dotfiles
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

Now, change the font of Konsole to "FiraCode NF 12pt" and theme for Dracula.

Click in Edit Dracula theme, mark the Blur Background option, and set transparency to 4%.



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



### Configuring Konsole

Go to Settings > Tooolbars Show, and mark off `Session Toolbar` and `Main Toolbar`, after that, press `Ctrl + Shift + m` to hide Menubar.



### Install Lightly Application Style

```bash
yay -S lightly-git
```



### Install RoundedSBE Window Decoration

```bash
# Dependencies
yay -S git make cmake gcc gettext extra-cmake-modules qt5-tools kcrash kglobalaccel kde-dev-utils kio knotifications kinit kwin kdecoration qt5-declarative qt5-x11extras

# Installation
git clone git@github.com:a-parhom/RoundedSBE.git /tmp/RoundedSBE
cd /tmp/RoundedSBE
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DKDE_INSTALL_LIBDIR=lib -DBUILD_TESTING=OFF -DKDE_INSTALL_USE_QT_SYS_PATHS=ON
make
sudo make install

kwin_x11 --replace
```



## Global Theme, Icon theme, and more

### Global Theme

Just download the **Monterey dark theme** globally, but don't change it.



### Application Style

Choose **Lightly**. And edit the Lightly theme:

- Mark the first 2 options in General, and change *Corner radius* to 8px.
- In Transparency tab, change Menu level to 8, starting from 1, and Sidebars to 11, the maximum.



### Plasma Style

In Plasma Style, search for **WhiteSur Dark**. And switch the current theme to it.



### Colors

Seach for **Monterey color scheme**, and change to it. Also, mark **Use accent color from current color Scheme** option on top.



### Window Decorations

Choose **Rounded SBE**. Edit the theme:

- Button Style to ***SBE Sierra Inactive***
- Button Spacing to 4px
- Button padding to 4px
- Mark the ***User System Foreground Colors*** option.
- Mark off the Draw Separator between Title bar and Window
- Gradient Intensity to 25%
- Background Opacity to 92%
- In "Window Corners" tab, raise the Corner radius to 12px.



In "Title Buttons" Tab, leave just the minimize and close buttons.



### Fonts

Change every font, except *Fixed with* to **SF Pro Display**



### Icons Theme

I like to switch between icon themes often. But the main Icon Themes which I like are:

- WhiteSur-dark
- Papirus-Dark
- Reversal-blue-dark



### Cursors

- WhiteSur Cursors; or
- Breeze original cursor theme from Plasma.



### Splash Screen

- Monterey-dark



### Login Screen

Go to Startup and Shutdown > Login Screen (SDDM), and search for **Monterey** theme. Select it.



### Wallpaper

Search for **Macos Monterey**, also the Dark version, and select it in Desktop Wallpaper and Screen Locking > Appearance.

But you also can use a plugin to have Dynamic Wallpapers, download the package:

```bash
yay -S plasma5-wallpapers-dynamic
```

This plugin accepts avif files as input. I leave this file from Monterey theme in this repo. After download the plugin, go to setup wallpapers in KDE, select the plugin, add wallpaper, and then select the monterey.avif file. This one is very simple, just two images, one for day and the other for night. But this plugin allows you to have many configurations, even one related to sun position in your current localization and time, visit their website to check more about it.



## Latte Dock and Widgets

 

Install the following widgets:

- Win7 Volume Mixer
- Win7 Show Desktop
- Clear Clock by qewer
- Kickoff/Grid
- Latte Separator
- Latte Spacer
- Event Calendar
- via **yay:**
  - plasma5-applets-virtual-desktop-bar-git
  - plasma5-wallpapers-wallpaper-engine-git (Allows you to have the wallpapers from Wallpaper Engine from Steam in your KDE)



Install Latte-dock:

```bash
yay -S latte-dock-git
```



After that, remove the default panel from KDE, and open the Latte Dock app.

Right click in it, and click in Layouts > Edit Layouts, after that, click in Import, and select the layout downloaded from dotfiles repository.

Switch for the new layout **kde-win11**. (make sure you are running in Xorg11 instead Wayland, there is something in this layout that crashes the Latte).



## Post install

After that, feel free to install your personal applications, some of them to check it out:

- Code Editor: VS Code and Neovim (I personally use the https://lunarvim.org/ IDE, config file is in this repo).
- Typora
- Chat apps: Discord, Slack, Telegram
- Steam, RetroArch, Minecraft, etc.
- Development apps related: Docker Desktop, Insomnia, Beekeper Studio, Figma, and so on
- Video related: OBS Studio, DaVinci Resolve
  - Set the incrontab -e to `/home/mendel/Videos     IN_CLOSE_WRITE  /usr/bin/ffmpeg -i $@/$# -c:v prores_ks -profile:v 3 -c:a pcm_s16be /home/mendel/DaVinci/$#.mov`, in order to auto convert mp4 recorded by OBS to be used in Resolve.
-  Install a sync cloud storage, I personally like MEGA Sync.
- Multimedia related: VLC, Spotify, Stremio.



#### Setting up Developer Environment

Here are some text to put in your zshrc related to programming stuff:

```sh
# ASDF installed with yay
. /opt/asdf-vm/asdf.sh

# pnpm
export PNPM_HOME="/home/mendel/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# RUST / CARGO BIN
export PATH="/home/mendel/.asdf/installs/rust/1.62.1/bin:$PATH"
export PATH="/home/mendel/.local/bin:$PATH"

# Aliases
alias ls="exa --icons"
alias cat="bat"
alias update="yay -Syyuu --noconfirm"
# Work stuff
alias api="cd ~/SpotPass/api"
alias docs="cd ~/SpotPass/docs"
alias manager="cd ~/SpotPass/manager"
```



After install asdf with yay, install some programming languages:

- Ruby
- Nodejs (also yarn, pnpm)
- Python
- Rust
  - Also, install some Rust utilities, like bat, exa...



TO-DO:

- [ ] Kvantum
- [ ] Grub
- [ ] Fonts
