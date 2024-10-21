# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# plugins
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh          #autosuggestions
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh  #syntax highlighting
source $ZDOTDIR/plugins/epic-man-pages/epic-man-pages.zsh                    #colored man pages

fpath=( $ZDOTDIR/plugins/zsh-completions/src $fpath )                        #extra completions

# zstyle
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' menu select

set -o emacs

# binds
bindkey "^[[127;5u"     backward-delete-word  # <C-BS>
bindkey "^[[3;5~"       delete-word         # <C-Del>
bindkey "^[[1;5C"       forward-word        # <C-Right>
bindkey "^[[1;5D"       backward-word       # <C-Left>
bindkey -s "^[[1:5B"    ""
bindkey -s "^[[13;5u"   ""

# aliases
source $ZDOTDIR/.zsh_aliases

# options
source $ZDOTDIR/.zsh_options

# prompt theme
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# The following lines were added by compinstall
zstyle :compinstall filename '/home/bauer/.config/zsh/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

