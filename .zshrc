# config pass
PATH=/usr/local/mysql/bin:$PATH
PATH=$HOME/app/bin/:/usr/local/bin:$HOME/.rbenv/bin:$PATH
export PATH
eval "$(rbenv init -)"

# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

# encoding
export LANG=ja_JP.UTF-8

# config history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# delete conflict history
setopt hist_ignore_dups
# don't remember same command
setopt hist_ignore_all_dups
# share history 
setopt share_history

# input completion enabled
autoload -Uz compinit
compinit -u
if [ -e /usr/local/share/zsh-complettions ]; then
  fpath=(/usr/local/share/zsh-complettions $fpath)
fi
# match up and down cases
zstyle ':completion:*' matcher-lsit 'm:[a-z]-[A-Z]'
# fill input completion
setopt list_packed
# completion color
zstyle ':completion:*' list-colors ''

#disable terminal output/input keys
stty start undef
stty stop undef

# fix spell miss
setopt correct
# silent beep
setopt no_beep

# use zmv
autoload -U zmv

# prompt
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{magenta}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{yellow}+"
zstyle ':vcs_info:*' formats "%F{cyan}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd() { vcs_info }
if [ -n "$VIMRUNTIME" ]; then
  PROMPT=$'😽  %F{yellow}(VIM)%f %D %*:${vcs_info_msg_0_} 😽  \n%F{green}%~%f %n %F{yellow}$%f '
else
  PROMPT=$'👿  %D %*:${vcs_info_msg_0_} 👿  \n%F{green}%~%f %n %F{yellow}$%f '
fi
#RPROMPT='${vcs_info_msg_0_}'
RPROMPT=''

# bind vim keys
bindkey -v
bindkey '\e[3~' delete-char
bindkey '^R' history-incremental-pattern-search-backward # for enable Ctrl+r
bindkey '^S' history-incremental-pattern-search-forward # for enable Ctrl+s

# history search
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# alias
alias ls='ls -aF'
alias ll='ls -l'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias vi='vim'
alias cat='cat -n'
alias less='less -NM'
alias neko='cat -n'
alias emozi=''
export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad


