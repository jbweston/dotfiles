# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set up ssh-agent
eval $(keychain --agents gpg,ssh --eval 2>/dev/null)

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export PATH="/home/jbw/.local/miniconda/bin:$PATH"

export GTK_IM_MODULE=xim
export XDG_CONFIG_HOME=$HOME/.config
export EDITOR=kak
export GIT_EDITOR=kak
export TERMINAL=urxvt
export PAGER=less
export LC_ALL=en_US.UTF-8
export terminal=$TERMINAL
export EMAIL="Joseph Weston <me@josephweston.org>"

alias ghci="stack ghci"
alias ghc="stack ghc"

eval "$(stack --bash-completion-script stack)"

. /home/jbw/.local/miniconda/etc/profile.d/conda.sh

export PATH="$HOME/.cargo/bin:$PATH"

export PATH="$HOME/.poetry/bin:$PATH"
