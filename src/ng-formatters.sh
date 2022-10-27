#!/bin/bash
#
# Regards, the Alveare Solutions society.
#
# FORMATTERS

# TODO
function format_display_bot_ctrl_settings_args() {
    echo "[ WARNING ]: Under construction, building..."
#   local ARGUMENTS=(
#
#   )
#   echo ${ARGUMENTS[@]}
    return $?
}

function format_display_main_settings_args () {
    local ARGUMENTS=(
        'local-ip' 'external-ip'
    )
    echo ${ARGUMENTS[@]}
    return $?
}

function format_display_project_settings_args () {
    local ARGUMENTS=(
        'project-path'
        'log-dir'
        'conf-dir'
        'cron-dir'
        'log-file'
        'conf-file'
        'conf-json-file'
        'log-lines'
        'system-user'
        'system-pass'
        'system-perms'
        'hostname-file'
        'hosts-file'
        'wpa-file'
        'cron-file'
        'bashrc-file'
        'bashaliases-file'
        'bashrc-template'
        'silence'
        'local-ip'
        'external-ip'
        'wifi-essid'
        'wifi-pass'
        'wpa-dir'
        'hosts-dir'
        'hostname-dir'
        'data-dir'
        'action'
        'ticker-symbol'
        'watch-interval'
        'watch-flag'
        'watch-anchor-file'
        'period'
        'period-interval'
        'period-start'
        'period-end'
        'action-header'
        'write-flag'
        'write-mode'
        'out-file'
        'action-target'
        'base-currency'
        'exchange-currency'
        'crypto-topx'
        'quantity'
    )
    echo ${ARGUMENTS[@]}
    return $?
}

function format_display_analysis_ctrl_settings_args() {
    local ARGUMENTS=(
        'action' 'ticker-symbol' 'watch-interval' 'watch-flag' 'period-end'
        'watch-anchor-file' 'period' 'period-interval' 'period-start'
        'action-header' 'write-flag' 'write-mode' 'out-file' 'action-target'
        'base-currency' 'exchange-currency' 'crypto-topx' 'quantity'
    )
    echo ${ARGUMENTS[@]}
    return $?
}

function format_currency_convertor_cargo_args() {
    local ARGUMENTS=(
        `format_nomadsgold_cargo_constant_args`
        '--action currency-convertor'
        '--action-target currency'
        "--base-currency ${MD_DEFAULT['base-currency']}"
        "--exchange-currency ${MD_DEFAULT['exchange-currency']}"
        "--quantity ${MD_DEFAULT['quantity']}"
    )
    echo -n "${ARGUMENTS[@]}"
    return $?
}

function format_crypto_topx_cargo_args() {
    local ARGUMENTS=(
        `format_nomadsgold_cargo_constant_args`
        '--action crypto-topx'
        '--action-target crypto'
        "--crypto-topx ${MD_DEFAULT['crypto-topx']}"
        "--base-currency ${MD_DEFAULT['base-currency']}"
        "--period ${MD_DEFAULT['period']}"
        "--period-interval ${MD_DEFAULT['period-interval']}"
        "--period-start ${MD_DEFAULT['period-start']}"
        "--period-end ${MD_DEFAULT['period-end']}"
    )
    echo -n "${ARGUMENTS[@]}"
    return $?
}

function format_currency_chart_cargo_args() {
    local ARGUMENTS=(
        `format_nomadsgold_cargo_constant_args`
        '--action currency-chart'
        '--action-target currency'
        "--base-currency ${MD_DEFAULT['base-currency']}"
        "--exchange-currency ${MD_DEFAULT['exchange-currency']}"
        "--period ${MD_DEFAULT['period']}"
        "--period-interval ${MD_DEFAULT['period-interval']}"
        "--period-start ${MD_DEFAULT['period-start']}"
        "--period-end ${MD_DEFAULT['period-end']}"
    )
    echo -n "${ARGUMENTS[@]}"
    return $?
}

function format_stock_price_history_cargo_args() {
    local ARGUMENTS=(
        `format_nomadsgold_cargo_constant_args`
        '--action price-history'
        '--action-target stock'
        "--ticker-symbol ${MD_DEFAULT['ticker-symbol']}"
        "--period ${MD_DEFAULT['period']}"
        "--period-interval ${MD_DEFAULT['period-interval']}"
        "--period-start ${MD_DEFAULT['period-start']}"
        "--period-end ${MD_DEFAULT['period-end']}"
    )
    echo -n "${ARGUMENTS[@]}"
    return $?
}

function format_stock_recommendations_cargo_args() {
    local ARGUMENTS=(
        `format_nomadsgold_cargo_constant_args`
        '--action recommendations'
        '--action-target stock'
        "--ticker-symbol ${MD_DEFAULT['ticker-symbol']}"
    )
    echo -n "${ARGUMENTS[@]}"
    return $?
}

function format_stock_info_cargo_args() {
    local ARGUMENTS=(
        `format_nomadsgold_cargo_constant_args`
        '--action stock-info'
        '--action-target stock'
        "--ticker-symbol ${MD_DEFAULT['ticker-symbol']}"
    )
    echo -n "${ARGUMENTS[@]}"
    return $?
}

function format_stock_price_open_cargo_args() {
    local ARGUMENTS=(
        `format_nomadsgold_cargo_constant_args`
        '--action price-open'
        '--action-target stock'
        "--ticker-symbol ${MD_DEFAULT['ticker-symbol']}"
        "--period ${MD_DEFAULT['period']}"
        "--period-interval ${MD_DEFAULT['period-interval']}"
        "--period-start ${MD_DEFAULT['period-start']}"
        "--period-end ${MD_DEFAULT['period-end']}"
    )
    echo -n "${ARGUMENTS[@]}"
    return $?
}

function format_stock_price_close_cargo_args() {
    local ARGUMENTS=(
        `format_nomadsgold_cargo_constant_args`
        '--action price-close'
        '--action-target stock'
        "--ticker-symbol ${MD_DEFAULT['ticker-symbol']}"
        "--period ${MD_DEFAULT['period']}"
        "--period-interval ${MD_DEFAULT['period-interval']}"
        "--period-start ${MD_DEFAULT['period-start']}"
        "--period-end ${MD_DEFAULT['period-end']}"
    )
    echo -n "${ARGUMENTS[@]}"
    return $?
}

function format_stock_price_high_cargo_args() {
    local ARGUMENTS=(
        `format_nomadsgold_cargo_constant_args`
        '--action price-high'
        '--action-target stock'
        "--ticker-symbol ${MD_DEFAULT['ticker-symbol']}"
        "--period ${MD_DEFAULT['period']}"
        "--period-interval ${MD_DEFAULT['period-interval']}"
        "--period-start ${MD_DEFAULT['period-start']}"
        "--period-end ${MD_DEFAULT['period-end']}"
    )
    echo -n "${ARGUMENTS[@]}"
    return $?
}

function format_stock_price_low_cargo_args() {
    local ARGUMENTS=(
        `format_nomadsgold_cargo_constant_args`
        '--action price-low'
        '--action-target stock'
        "--ticker-symbol ${MD_DEFAULT['ticker-symbol']}"
        "--period ${MD_DEFAULT['period']}"
        "--period-interval ${MD_DEFAULT['period-interval']}"
        "--period-start ${MD_DEFAULT['period-start']}"
        "--period-end ${MD_DEFAULT['period-end']}"
    )
    echo -n "${ARGUMENTS[@]}"
    return $?
}

function format_stock_volume_cargo_args() {
    local ARGUMENTS=(
        `format_nomadsgold_cargo_constant_args`
        '--action volume'
        '--action-target stock'
        "--ticker-symbol ${MD_DEFAULT['ticker-symbol']}"
        "--period ${MD_DEFAULT['period']}"
        "--period-interval ${MD_DEFAULT['period-interval']}"
        "--period-start ${MD_DEFAULT['period-start']}"
        "--period-end ${MD_DEFAULT['period-end']}"
    )
    echo -n "${ARGUMENTS[@]}"
    return $?
}

function format_company_calendar_cargo_args() {
    local ARGUMENTS=(
        `format_nomadsgold_cargo_constant_args`
        '--action company-calendar'
        '--action-target stock'
    )
    echo -n "${ARGUMENTS[@]}"
    return $?
}

function format_show_supported_currencies_cargo_args() {
    local ARGUMENTS=(
        `format_nomadsgold_cargo_constant_args`
        '--action show-currencies'
        '--action-target currency'
    )
    echo -n "${ARGUMENTS[@]}"
    return $?
}

function format_show_supported_crypto_cargo_args() {
    local ARGUMENTS=(
        `format_nomadsgold_cargo_constant_args`
        '--action show-crypto'
        '--action-target crypto'
    )
    echo -n "${ARGUMENTS[@]}"
    return $?
}


function format_setup_machine_cargo_arguments() {
    local ARGUMENTS=( `format_nomadsgold_cargo_constant_args` '--action setup' )
    echo -n "${ARGUMENTS[@]}"
    return $?
}

function format_nomadsgold_cargo_constant_args() {
    local ARGUMENTS=(
        "--log-file ${MD_DEFAULT['log-file']}"
        "--config-file ${MD_DEFAULT['conf-json-file']}"
    )
    if [[ ${MD_DEFAULT['silence']} == 'on' ]]; then
        local ARGUMENTS=( ${ARGUMENTS[@]} '--silence' )
    fi
    if [[ ${MD_DEFAULT['watch-flag']} == 'on' ]]; then
        local ARGUMENTS=( ${ARGUMENTS[@]}
            '--watch'
            "--watch-interval ${MD_DEFAULT['watch-interval']}"
        )
    fi
    if [[ ${MD_DEFAULT['write-flag']} == 'on' ]]; then
        local ARGUMENTS=( ${ARGUMENTS[@]}
            '--write'
            "--out-file ${MD_DEFAULT['out-file']}"
        )
    fi
    echo -n "${ARGUMENTS[@]}"
    return $?
}

function format_config_json_flag() {
    local FLAG_VALUE="$1"
    case "$FLAG_VALUE" in
        'on'|'On'|'ON')
            echo 'true'
            ;;
        'off'|'Off'|'OFF')
            echo 'false'
            ;;
        *)
            echo $FLAG_VALUE
            return 1
            ;;
    esac
    return 0
}

function format_config_json_file_content() {
    cat<<EOF
{
    "NG_SCRIPT_NAME":            "${NG_SCRIPT_NAME}",
    "NG_VERSION":                "${NG_VERSION}",
    "NG_VERSION_NO":             "${NG_VERSION_NO}",
    "NG_DIRECTORY":              "$NG_DIRECTORY",
    "NG_DEFAULT": {
         "project-path":         "${MD_DEFAULT['project-path']}",
         "home-dir":             "${MD_DEFAULT['home-dir']}",
         "log-dir":              "${MD_DEFAULT['log-dir']}",
         "conf-dir":             "${MD_DEFAULT['conf-dir']}",
         "lib-dir":              "${MD_DEFAULT['lib-dir']}",
         "src-dir":              "${MD_DEFAULT['src-dir']}",
         "dox-dir":              "${MD_DEFAULT['dox-dir']}",
         "dta-dir":              "${MD_DEFAULT['dta-dir']}",
         "bin-dir":              "${MD_DEFAULT['bin-dir']}",
         "tmp-dir":              "${MD_DEFAULT['tmp-dir']}",
         "spl-dir":              "${MD_DEFAULT['spl-dir']}",
         "cron-dir":             "${MD_DEFAULT['cron-dir']}",
         "log-file":             "`basename ${MD_DEFAULT['log-file']}`",
         "conf-file":            "`basename ${MD_DEFAULT['conf-json-file']}`",
         "init-file":            "${MD_DEFAULT['init-file']}",
         "hostname-file":        "${MD_DEFAULT['hostname-file']}",
         "hosts-file":           "${MD_DEFAULT['hosts-file']}",
         "wpa-file":             "${MD_DEFAULT['wpa-file']}",
         "cron-file":            "${MD_DEFAULT['cron-file']}",
         "boot-file":            "${MD_DEFAULT['boot-file']}",
         "log-format":           "${MD_DEFAULT['log-format']}",
         "timestamp-format":     "${MD_DEFAULT['timestamp-format']}",
         "silence":              `format_config_json_flag ${MD_DEFAULT['silence']}`,
         "system-user":          "${MD_DEFAULT['system-user']}",
         "system-pass":          "${MD_DEFAULT['system-pass']}",
         "system-perms":          ${MD_DEFAULT['system-perms']},
         "wifi-essid":           "${MD_DEFAULT['wifi-essid']}",
         "wifi-pass":            "${MD_DEFAULT['wifi-pass']}",
         "bashrc-file":          "${MD_DEFAULT['bashrc-file']}",
         "bashrc-template":      "${MD_DEFAULT['bashrc-template']}",
         "bashaliases-file":     "${MD_DEFAULT['bashaliases-file']}",
         "action":               "${MD_DEFAULT['action']}",
         "ticker-symbol":        "${MD_DEFAULT['ticker-symbol']}",
         "watch-interval":       ${MD_DEFAULT['watch-interval']},
         "watch-cleanup":        "${MD_DEFAULT['watch-cleanup']}",
         "watch-flag":           `format_config_json_flag ${MD_DEFAULT['watch-flag']}`,
         "watch-anchor-file":    "${MD_DEFAULT['watch-anchor-file']}",
         "period":               "${MD_DEFAULT['period']}",
         "period-start":         "${MD_DEFAULT['period-start']}",
         "period-end":           "${MD_DEFAULT['period-end']}",
         "action-header":        `format_config_json_flag ${MD_DEFAULT['action-header']}`,
         "write-flag":           `format_config_json_flag ${MD_DEFAULT['write-flag']}`,
         "write-mode":           "${MD_DEFAULT['write-mode']}",
         "out-file":             "${MD_DEFAULT['out-file']}",
         "rate-sx-url":          "${MD_DEFAULT['rate-sx-url']}",
         "action-target":        "${MD_DEFAULT['action-target']}",
         "base-currency":        "${MD_DEFAULT['base-currency']}",
         "exchange-currency":    "${MD_DEFAULT['exchange-currency']}",
         "quantity":             "${MD_DEFAULT['quantity']}"
    },
    "NG_CARGO": {
        "nomads-gold":       "${MD_CARGO['nomads-gold']}"
    }
}
EOF
    return $?
}


