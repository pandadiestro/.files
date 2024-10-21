export EDITOR="nvim"
export VISUAL="nvim"

export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:/sbin:/home/bauer/.local/bin"
export PATH="$PATH:/home/bauer/userbin/gradle/gradle-8.3/bin"

export XDG_HOME="/home/bauer"
export XDG_CONFIG_HOME="$XDG_HOME/.config"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export HISTFILE="$ZDOTDIR/.zhistory"
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file

# export LS_COLORS="di=1;37:ln=1;36:so=1;31:pi=31:ex=1;0:bd=1;34;47:cd=1;30;47:su=30;41:sg=30;46:tw=1;30;42:ow=1;30;43"
export LS_COLORS="di=38;5;251:ln=1;36:so=1;31:pi=31:ex=1;0:bd=1;34;47:cd=1;30;47:su=30;41:sg=30;46:tw=1;30;42:ow=1;30;43"
export EXA_ICON_SPACING=2

export PF_INFO="ascii os kernel uptime pkgs memory de wm"

export JAVA_HOME="/usr/lib/jvm/java-1.17.0-openjdk-amd64"

# fzf defaults
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'



. "$HOME/.cargo/env"
