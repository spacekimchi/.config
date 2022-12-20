# .bashrc


#aliases
alias sb='source ~/.bashrc'
alias ws='cd ~/workspace'
alias r2k='cd ~/workspace/road22k'
alias plantz='cd ~/workspace/plantz'
alias ali='nvim ~/.bashrc'
alias vimrc='nvim ~/.vimrc'
alias nvimrc='nvim ~/.config/nvim/init.vim'
alias rb='cd ~/workspace/rust-book'
alias vim='nvim'
alias lc='cd ~/workspace/leetcodes'
alias aoc='cd ~/workspace/aoc-2021'
alias weather='curl wttr.in'
alias sl='cd ~/.suckless'
alias sks='cd ~/workspace/stockrs'
alias kbs='xset r rate 300 50'
alias spd='cd ~/workspace/spida'
alias wci='cd ~/workspace/what_can_i_make'
alias wcim='cd ~/workspace/wcim'
alias mul="cd ~/workspace/mul"
alias cpa="cd ~/workspace/wcim-fe/copia"
alias vd="cd ~/workspace/verde"
alias bg="~/.fehbg"
alias wbe="cd ~/workspace/weatherist"
alias wfe="cd ~/workspace/weether"

alias m="mullvad"

#git aliases
alias gs='git status'
alias gco='git checkout'
alias g='git'
alias ga='git add'

# git bash-completion
for file in /etc/bash_completion.d/* ; do
    source "$file"
done


# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc
. "$HOME/.cargo/env"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/ssg/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ssg/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/ssg/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/ssg/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

