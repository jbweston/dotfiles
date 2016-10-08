#! /usr/bin/env python2

from subprocess import check_output
import os

def get_pass(account):
    return check_output("pass {}".format(account), shell=True, env=os.environ).strip('\n')
