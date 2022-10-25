#!/bin/bash
#
# Regards, the Alveare Solutions society.
#
# CHECKERS

# TODO - Add to machine dialogue
function check_file_path () {
    local FILE_PATH="$1"
    local CHAR_COUNT=`echo ${FILE_PATH} | wc -c`
    local WORD_COUNT=`echo ${FILE_PATH} | wc -w`
    local EXIT_CODE=1
    if [[ $WORD_COUNT -eq 1 ]]; then
        for i in `seq 0 $CHAR_COUNT`; do
            if [[ "${FILE_PATH:${i}:1}" == '/' ]]; then
                local EXIT_CODE=0
                break
            fi
        done
    fi
    return $EXIT_CODE
}

