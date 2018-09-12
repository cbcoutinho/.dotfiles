#!/usr/bin/env python
#
# This function returns an account password using the `pass` command.
# An account must be provided as input

from subprocess import check_output, STDOUT

def get_pass(account):
    command = "pass Mail/" + account

    output = check_output(
        command,
        shell=True,
        stderr=STDOUT,
    )

    outtext = output.splitlines()[0]

    return outtext
