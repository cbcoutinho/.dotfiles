#!/usr/bin/python
#
# This function returns my Google password from my local password-store
# in my home directory. It is called by `offlineimap`, which can be
# insatlled in a virtualenv or by the system. On Tumbleweed, this was
# available in the main repositories

from subprocess import check_output, STDOUT

def get_pass(account=None):
    command = "pass Mail/" + account

    output = check_output(
        command,
        shell=True,
        stderr=STDOUT,
    )

    outtext = output.splitlines()[0]

    return outtext
