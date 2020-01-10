TERM=xterm-256color

# -----------------------------------------------------------------------------------------------------------------------------
# ENVIRONMENT_VARIABLES
# -----------------------------------------------------------------------------------------------------------------------------

export COLORTERM=24bit

export ZSH=$HOME/.config/oh-my-zsh
export ZDOTDIR=$HOME/.config/zsh
export XDG_DATA_HOME=$HOME/.local/share
export RTV_BROWSER=w3m
export TMOUT=9600
export PAGER=less

# PIPENV
export PIPENV_DEFAULT_PYTHON_VERSION=3
export PIPENV_MAX_DEPTH=5
export PIPENV_SKIP_LOCK=1
export PIPENV_SPINNER=pong
export PIPENV_DOTENV_LOCATION="$HOME/Pipenv/.env"

# LESS
export LESS='-R'
export LESSOPEN='|file-preview %s'

# dir colors cd
# zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# -----------------------------------------------------------------------------------------------------------------------------
# GENERAL
# -----------------------------------------------------------------------------------------------------------------------------

ENABLE_CORRECTION="true"
setopt AUTO_CD
setopt NO_BEEP
setopt NO_CASE_GLOB
setopt EXTENDED_GLOB

ZSH_DISABLE_COMPFIX=true

# History in cache directory:
export HISTSIZE=10000000
export SAVEHIST=10000000
export HISTFILE=$HOME/.cache/zsh/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit_comp_options+=(globdots)		# Include hidden files.

compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# -----------------------------------------------------------------------------------------------------------------------------
# OHMYZSH
# -----------------------------------------------------------------------------------------------------------------------------

ZSH_THEME="powerzeesh"
plugins=(
docker
docker-compose
kubectl
# git
notify
vi-mode
fzf-tab
zsh-autosuggestions
zsh-completions
zsh-dircolors-solarized
zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# notify
zstyle ':notify:*' command-complete-timeout 10

zstyle ':notify:*' error-title "Command failed (in #{time_elapsed} seconds)"
zstyle ':notify:*' success-title "Command finished (in #{time_elapsed} seconds)"

zstyle ':notify:*' error-icon "$HOME/Pictures/Notifications/error.png"
zstyle ':notify:*' success-icon "$HOME/Pictures/Notifications/success.png"

# -----------------------------------------------------------------------------------------------------------------------------
# BINDKEY
# -----------------------------------------------------------------------------------------------------------------------------

bindkey 'µ' autosuggest-accept
bindkey '^[[Z' reverse-menu-complete

# -----------------------------------------------------------------------------------------------------------------------------
# ALIASES
# -----------------------------------------------------------------------------------------------------------------------------

if [[ -n "$SSH_CONNECTION" ]] ; then

    banner_info

    alias v='vim'

    export EDITOR="vim"
    export TERM="xterm"

elif [[ $TTY != "/dev/tty1" ]]; then

    zle-keymap-select () {
        if [ $KEYMAP = vicmd ]; then
            echo -ne '\e[1 q'
        else
            echo -ne '\e[5 q'
        fi
    }
    zle-line-init () {
        zle -K viins
        echo -ne "\033]12;Grey\007"
    }

fi

# -----------------------------------------------------------------------------------------------------------------------------
# FZF
# -----------------------------------------------------------------------------------------------------------------------------

export FZF_DEFAULT_COMMAND="rg --files -L --hidden --ignore-file .gitignore_global ."
export FZF_DEFAULT_OPTS='-m --height 40% --layout=reverse --border --bind ctrl-k:preview-up,ctrl-j:preview-down,ctrl-d:preview-page-down,ctrl-u:preview-page-up'

# -----------------------------------------------------------------------------------------------------------------------------
# MISC
# -----------------------------------------------------------------------------------------------------------------------------

source "$ZDOTDIR/functions.zsh"
source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/sources.zsh"
