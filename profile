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
GTK_IM_MODULE=xim
# logfile for `t` command based on year/month
export TIMELOG="$HOME/work/timelog/$(date +%Y/%m).ldg"
[[ ! -d ${TIMELOG%/**} ]] && mkdir -p ${TIMELOG%/**}
[[ ! -f "$TIMELOG" ]] && touch $TIMELOG
