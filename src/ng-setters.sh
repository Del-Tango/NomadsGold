#!/bin/bash
#
# Regards, the Alveare Solutions society.
#
# SETTERS

function set_action() {
    local ACTION="$1"
    MD_DEFAULT['action']=$ACTION
    return 0
}

function set_action_target() {
    local TARGET="$1"
    MD_DEFAULT['action-target']=$TARGET
    return 0
}

function set_period_end_date() {
    local DATE="$1"
    MD_DEFAULT['period-end']=$DATE
    return 0
}

function set_period_start_date() {
    local DATE="$1"
    MD_DEFAULT['period-start']=$DATE
    return 0
}

function set_period_interval() {
    local INTERVAL="$1"
    MD_DEFAULT['period-interval']=$INTERVAL
    return 0
}

function set_period() {
    local ="$1"
    MD_DEFAULT['period']=$PERIOD
    return 0
}

function set_watch_anchor_file() {
    local FILE_PATH="$1"
    MD_DEFAULT['watch-anchor-file']=$FILE_PATH
    return 0
}

function set_watch_interval() {
    local INTERVAL="$1"
    MD_DEFAULT['watch-interval']=$INTERVAL
    return 0
}

function set_exchange_currency() {
    local CURRENCY="$1"
    MD_DEFAULT['exchange-currency']=$CURRENCY
    return 0
}

function set_base_currency() {
    local CURRENCY="$1"
    MD_DEFAULT['base-currency']=$CURRENCY
    return 0
}

function set_stock_symbol() {
    local SYMBOL="$1"
    MD_DEFAULT['ticker-symbol']=$SYMBOL
    return 0
}

function set_quantity() {
    local QUANTITY="$1"
    MD_DEFAULT['quantity']=$QUANTITY
    return 0
}

function set_out_file() {
    local FILE_PATH="$1"
    MD_DEFAULT['out-file']=$FILE_PATH
    return 0
}

function set_crypto_topx() {
    local CRYPTO_TOPX="$1"
    MD_DEFAULT['crypto-topx']=$CRYPTO_TOPX
    return 0
}

function set_action_header_flag() {
    local FLAG="$1"
    MD_DEFAULT['action-header']="$FLAG"
    return 0
}

function set_write_flag() {
    local FLAG="$1"
    MD_DEFAULT['write']="$FLAG"
    return 0
}

function set_watch_flag() {
    local FLAG="$1"
    MD_DEFAULT['watch']="$FLAG"
    return 0
}

function set_wifi_password() {
    local WIFI_PASS="$1"
    MD_DEFAULT['wifi-pass']="$WIFI_PASS"
    return 0
}

function set_wifi_essid() {
    local WIFI_ESSID="$1"
    MD_DEFAULT['wifi-essid']="$WIFI_ESSID"
    return 0
}

function set_system_user() {
    local USER_NAME="$1"
    MD_DEFAULT['system-user']="$USER_NAME"
    return 0
}

function set_system_password() {
    local SYS_PASS="$1"
    MD_DEFAULT['system-pass']="$SYS_PASS"
    return 0
}

function set_user_file_permissions() {
    local OCTAL_PERMS=$1
    MD_DEFAULT['system-perms']=$OCTAL_PERMS
    return 0
}

function set_silence_flag() {
    local FLAG="$1"
    MD_DEFAULT['silence']="$FLAG"
    return 0
}

function set_user_cron_file() {
    local FILE_PATH="$1"
    MD_DEFAULT['cron-file']="$FILE_PATH"
    return 0
}

function set_system_hosts_file() {
    local FILE_PATH="$1"
    MD_DEFAULT['hosts-file']="$FILE_PATH"
    return 0
}

function set_system_hostname_file() {
    local FILE_PATH="$1"
    MD_DEFAULT['hostname-file']="$FILE_PATH"
    return 0
}

function set_user_bash_aliases_file() {
    local FILE_PATH="$1"
    MD_DEFAULT['bashaliases-files']="$FILE_PATH"
    return 0
}

function set_user_bashrc_file() {
    local FILE_PATH="$1"
    MD_DEFAULT['bashrc-file']="$FILE_PATH"
    return 0
}

function set_user_bashrc_template_file() {
    local FILE_PATH="$1"
    MD_DEFAULT['bashrc-template']="$FILE_PATH"
    return 0
}

function set_system_wpa_supplicant_file() {
    local FILE_PATH="$1"
    MD_DEFAULT['wpa-file']="$FILE_PATH"
    return 0
}

function set_json_config_file() {
    local FILE_PATH="$1"
    MD_DEFAULT['conf-json-file']="$FILE_PATH"
    return 0
}

function set_config_file() {
    local FILE_PATH="$1"
    MD_DEFAULT['conf-file']="$FILE_PATH"
    return 0
}

# CODE DUMP

