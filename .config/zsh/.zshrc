# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/kia/.local/share/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="mh"
export EDITOR="nvim"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Set historyfile
HISTFILE=/home/kia/.config/zsh/.zsh_history

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git kitty)

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"
# RUST PATH
export PATH="/home/kia/.cargo/bin:$PATH"

# android sdk path
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

#export path
export PATH=/home/kia/.local/bin:$PATH

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# SSH askpass
export SSH_ASKPASS=/usr/bin/ksshaskpass
export SSH_ASKPASS_REQUIRE=prefer

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# aliases

# CONFIGS ---->
alias vim="nvim"
alias polyconfig="vim ~/.config/polybar/config"
alias zshconfig="vim ~/.config/zsh/.zshrc"
alias bspconfig="vim ~/.config/bspwm/bspwmrc"
alias sxhconfig="vim ~/.config/sxhkd/sxhkdrc"
alias picomconfig="vim ~/.config/picom/picom.conf"
alias riverconfig="vim ~/.config/river/init"
alias waybarconfig="vim ~/.config/waybar/config ~/.config/waybar/style.css"
alias swayconfig="nvim ~/.config/sway/config"

# ALIASES ---->
alias dotconfig='/usr/bin/git --git-dir=$HOME/.config/dotfiles/ --work-tree=$HOME'
alias reinstallGrub='sudo grub-mkconfig -o /boot/grub/grub.cfg;sudo grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB'
alias quickfix="sudo cat /sys/kernel/debug/dri/1/amdgpu_gpu_recover"
alias psqlConnect="sudo -u postgres psql -h localhost"
