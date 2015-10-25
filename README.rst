jbw's dotfiles
==============
Just my dotfiles + install script

Installing
==========
run

    ./setup.sh

from the dotfile root directory (i.e. this one).

This script creates symlinks from files in this repository to the corresponding
dotfiles in you home directory. Symlinks are used because we also need to link
whole directories (e.g. `Xresources.d`). This means that you shouldn't move
this repository after having run `setup.sh`, else all the links will break. If
you ever *do* move this repository, simply re-run `setup.sh`.

Notes
=====
Password storage
----------------
`offlineimap` and `mutt` both require passwords to various mailboxes
and imap accounts. Clearly the credentials are not stored in this git repository,
and in general it is probably a bad idea to have unencrypted credentials stored in 
files. I get around this by encrypting my passwords with gpg:

    gpg -r D2C4E1B6 --encrypt > passwd.pgp

I keep the passwords in `.mutt/passwd`, and have them  decrypted on-fly
whenever I need them (I also use `gpg-agent` to avoid having to type my password
every time, but use a sensible expiry time).

Diff tool
---------
The script `diff-dotfiles.sh` prints diffs between all the dotfiles in the repository and their counterparts in your home directory. You can specify specific files/directories to diff as command line arguments, or specify nothing to diff all files.
