#!/usr/bin/python3
#
# Regards, the Alveare Solutions #!/Society -x
#
# SHELL

import logging

from subprocess import Popen, PIPE

log = logging.getLogger('AsymetricRisk')


def shell_cmd(command, user=None):
    log.debug('')
    log.debug('Issuing system command: ({})'.format(command))
    if user:
        command = "su {} -c \'{}\'".format(user, command)
    process = Popen(command, shell=True, stdout=PIPE, stderr=PIPE)
    output, errors = process.communicate()
    log.debug('Output: ({}), Errors: ({})'.format(output, errors))
    return  str(output).rstrip('\n'), str(errors).rstrip('\n'), process.returncode

