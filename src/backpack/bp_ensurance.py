#!/usr/bin/python3
#
# Regards, the Alveare Solutions #!/Society -x
#
# ENSURANCE

import logging

from os import path, makedirs, mkfifo

log = logging.getLogger('')


def ensure_fifo_exists(*args):
    log.debug('')
    failures = 0
    for fifo_path in args:
        try:
            create = mkfifo(fifo_path)
        except OSError as e:
            log.error(e)
            failures += 1
    return False if failures else True


def ensure_files_exist(*args):
    log.debug('')
    for file_path in args:
        with open(file_path, 'w', encoding='utf-8', errors='ignore'):
            pass
    return True


def ensure_directories_exist(*args):
    log.debug('')
    failures = 0
    for dir_path in args:
        try:
            create = makedirs(dir_path)
        except OSError as e:
            log.error(e)
            failures += 1
    return False if failures else True



