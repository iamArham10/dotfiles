# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme - robbyrussell is clean and fast, alternatives: agnoster, powerlevel10k
ZSH_THEME="robbyrussell"

# Uncomment for case-insensitive completion
# CASE_SENSITIVE="true"

# Hyphen-insensitive completion (_ and - are interchangeable)
HYPHEN_INSENSITIVE="true"

# Auto-update behavior
zstyle ':omz:update' mode auto

# Display red dots while waiting for completion
COMPLETION_WAITING_DOTS="true"

# ================================
# PLUGINS
# ================================
# Standard plugins: $ZSH/plugins/
# Custom plugins: $ZSH_CUSTOM/plugins/
plugins=(
    git                      # Git aliases and functions
    zsh-autosuggestions      # Fish-like autosuggestions
    zsh-syntax-highlighting  # Syntax highlighting for commands
    zsh-completions          # Additional completion definitions
    fzf                      # Fuzzy finder integration
    sudo                     # Press ESC twice to add sudo
    copypath                 # Copy current path to clipboard
    copyfile                 # Copy file contents to clipboard
    web-search               # Search from terminal (google, ddg, etc.)
    extract                  # Extract any archive with 'x' command
    z                        # Jump to frequently used directories
    command-not-found        # Suggest packages when command not found
    colored-man-pages        # Colorized man pages
    history                  # History command aliases
    aliases                  # Alias management
)

# Load completions
autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh

# ================================
# USER CONFIGURATION
# ================================

# Preferred editor
export EDITOR='nvim'
export VISUAL='nvim'

# History Configuration
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history
setopt EXTENDED_HISTORY          # Write timestamp to history
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicates first
setopt HIST_IGNORE_DUPS          # Don't record duplicates
setopt HIST_IGNORE_ALL_DUPS      # Delete old duplicate entry
setopt HIST_FIND_NO_DUPS         # No duplicates in search
setopt HIST_IGNORE_SPACE         # Don't record entries starting with space
setopt HIST_SAVE_NO_DUPS         # Don't write duplicates
setopt SHARE_HISTORY             # Share history between sessions
setopt HIST_VERIFY               # Show command before executing from history

# ================================
# KEYBINDINGS
# ================================
bindkey '^[[A' history-search-backward  # Up arrow - search history backward
bindkey '^[[B' history-search-forward   # Down arrow - search history forward
bindkey '^[[H' beginning-of-line        # Home
bindkey '^[[F' end-of-line              # End
bindkey '^[[3~' delete-char             # Delete
bindkey '^H' backward-kill-word         # Ctrl+Backspace - delete word backward
bindkey '^[[3;5~' kill-word             # Ctrl+Delete - delete word forward

# ================================
# AUTOSUGGESTIONS CONFIG
# ================================
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
bindkey '^ ' autosuggest-accept         # Ctrl+Space to accept suggestion

# ================================
# FZF CONFIGURATION
# ================================
export FZF_DEFAULT_OPTS='
  --height 40%
  --layout=reverse
  --border
  --info=inline
  --preview-window=right:50%:wrap
'
# Use fd if available for better performance
if command -v fd &> /dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
fi

# ================================
# USEFUL ALIASES
# ================================

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'

# List files (using eza - modern ls replacement)
alias ls='eza --icons --group-directories-first'
alias ll='eza -la --icons --group-directories-first --git'
alias la='eza -a --icons --group-directories-first'
alias l='eza --icons'
alias lt='eza -la --icons --sort=modified'
alias tree='eza --tree --icons --level=3'

# Safety
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Shortcuts
alias c='clear'
alias h='history'
alias j='jobs -l'
alias path='echo -e ${PATH//:/\\n}'

# Editor
alias v='nvim'
alias vim='nvim'
alias vi='nvim'

# Git shortcuts (in addition to oh-my-zsh git plugin)
alias gs='git status'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git log --oneline -20'
alias gla='git log --oneline --all --graph'
alias gco='git checkout'
alias gcm='git commit -m'
alias gp='git push'
alias gpl='git pull'

# System
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias top='btop'

# Modern CLI replacements
alias cat='bat --paging=never'
alias catp='bat'  # cat with pager
alias diff='delta'
alias lg='lazygit'
alias help='tldr'

# Grep with color
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Quick edit configs
alias zshrc='${EDITOR:-nvim} ~/.zshrc'
alias reload='source ~/.zshrc'

# ================================
# USEFUL FUNCTIONS
# ================================

# Create directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Find file by name (using fd)
ff() {
    fd --type f "$1"
}

# Find directory by name (using fd)
fdir() {
    fd --type d "$1"
}

# Extract any archive
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"    ;;
            *.tar.gz)    tar xzf "$1"    ;;
            *.bz2)       bunzip2 "$1"    ;;
            *.rar)       unrar x "$1"    ;;
            *.gz)        gunzip "$1"     ;;
            *.tar)       tar xf "$1"     ;;
            *.tbz2)      tar xjf "$1"    ;;
            *.tgz)       tar xzf "$1"    ;;
            *.zip)       unzip "$1"      ;;
            *.Z)         uncompress "$1" ;;
            *.7z)        7z x "$1"       ;;
            *)           echo "'$1' cannot be extracted" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Quick backup of a file
backup() {
    cp "$1" "$1.bak.$(date +%Y%m%d_%H%M%S)"
}

# Show top 10 most used commands
topcmd() {
    history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl | head -n20
}

# ================================
# PATH ADDITIONS
# ================================
export PATH="$HOME/.local/bin:$PATH"
# export PATH="$HOME/bin:$PATH"

# JetBrains Toolbox
export PATH="$PATH:$HOME/.local/share/JetBrains/Toolbox/scripts"

# Ruby gems
export PATH="$HOME/.local/share/gem/ruby/3.4.0/bin:$PATH"

# ================================
# LANGUAGE/TOOL SPECIFIC
# ================================

# Node Version Manager
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Rust
# source "$HOME/.cargo/env"

# Go
# export GOPATH="$HOME/go"
# export PATH="$PATH:$GOPATH/bin"

# ================================
# MODERN CLI TOOLS INITIALIZATION
# ================================

# Zoxide - smarter cd command
eval "$(zoxide init zsh)"
# Use 'z' for smart jumping, keep 'cd' for normal navigation
# z proj     → jumps to ~/projects (smart)
# cd ./src   → normal cd with tab completion
alias cdi='zi'    # Interactive directory selection with fzf

# Mise - polyglot version manager (node, python, etc.)
eval "$(mise activate zsh)"

# ================================
# YAZI - Terminal File Manager
# ================================
# Wrapper: 'y' opens yazi and cd's into the directory you quit from
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# ================================
# ADDITIONAL USEFUL FUNCTIONS
# ================================

# Preview files with bat and fzf
fzfp() {
    fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'
}

# Search file contents with ripgrep and fzf
rgi() {
    rg --color=always --line-number --no-heading --smart-case "${*:-}" |
    fzf --ansi \
        --color "hl:-1:underline,hl+:-1:underline:reverse" \
        --delimiter : \
        --preview 'bat --color=always {1} --highlight-line {2}' \
        --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
        --bind 'enter:become(nvim {1} +{2})'
}

# Quick HTTP requests with httpie
alias GET='http GET'
alias POST='http POST'
alias PUT='http PUT'
alias DELETE='http DELETE'

# Just (command runner) - auto-detect justfile
alias j='just'
alias jl='just --list'

# direnv config
eval "$(direnv hook zsh)"
export PATH="$HOME/.cargo/bin:$PATH"
export BROWSER="/usr/bin/google-chrome-stable"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
