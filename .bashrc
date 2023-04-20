# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# keychain
eval $(keychain --eval id_ed25519 -q --noask)

# aliases
alias sb='source ~/.bashrc'
alias ws='cd ~/workspace'
alias r2k='cd ~/workspace/road22k'
alias vali='nvim ~/.bashrc'
alias nvimrc='nvim ~/.config/.config/nvim/init.lua'
alias lc='cd ~/workspace/leetcodes'
alias sl='cd ~/.suckless'
alias tf='cd ~/workspace/traders-fe'
alias tb='cd ~/workspace/traders'
alias kbs='xset r rate 300 50'
alias bg="~/.fehbg"
alias wt="cd ~/workspace/weather/weatherist"
alias dm="xrandr --output DP-2 --primary --auto --right-of DP-1"
alias d="docker"
alias steam="flatpak run com.valvesoftware.Steam"

alias m="mullvad"

alias ds="flatpak run com.discordapp.Discord"
alias bs="flatpak run com.usebottles.bottles"

# git aliases
source /usr/share/bash-completion/completions/git
alias gs='git status'
__git_complete gco _git_checkout
alias gco='git checkout'
__git_complete ga _git_add
alias ga='git add'
__git_complete gp _git_push
alias gp='git push'

alias gcm='git commit -m'

. "$HOME/.cargo/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules,vendor,target,build}/*" -g "!*.{min.js,swp,o,zip}"'
bind -x '"\C-p": vim $(fzf);'
