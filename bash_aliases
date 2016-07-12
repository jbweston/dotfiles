# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# notify, useful for long-running commands
alias notify='tput bel'
alias tiga='tig --all'
alias tigs='tig status'
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

gpg-get-keys() {
    keys=$(gpg --list-sigs | grep "not found" | tr -s ' ' |\
           rev | cut -d' ' -f6 | rev)
    gpg --keyserver pgp.mit.edu --recv-keys $keys
}
