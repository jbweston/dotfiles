#! /usr/bin/env python2

from subprocess import check_output

def get_pass(account):
    return check_output("gpg -dq ~/.mutt/passwd/%s.gpg" % account,
                        shell=True).strip('\n')
