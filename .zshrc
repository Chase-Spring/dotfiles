# Path to your oh-my-zsh installation.
export ZSH="$HOME/dotfiles/.oh-my-zsh"
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration
# Useful globals, committed to dotfiles repo
if [ -f ~/.custom-alias ]; then
    source ~/.custom-alias
fi

# NVIM Dir config
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

VISUAL=vim
EDITOR="$VISUAL"
source /opt/local/share/nvm/init-nvm.sh

# I don't want the lesshist file
export LESSHISTFILE=-

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# MacPorts should be searched first
PATH=/opt/local/bin:$PATH
