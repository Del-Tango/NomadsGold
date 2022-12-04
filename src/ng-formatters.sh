#!/bin/bash
#
# Regards, the Alveare Solutions society.
#
# FORMATTERS


# TODO - Move to Machine Dialogue
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

function format_display_arisk_ctrl_settings_args() {
    local ARGUMENTS=(
        'ar-pid' 'ticker-symbol' 'base-currency' 'quote-currency' "ar-conf-file"
        "ar-profit-baby" "ar-watchdog-pid-file"
        "ar-watchdog-anchor-file" "ar-api-key" "ar-api-secret" "ar-taapi-key"
        "ar-api-url" "ar-taapi-url" "ar-max-trades" "ar-trading-account-type"
        "ar-trading-order-type" "ar-order-time-in-force" "ar-stop-loss"
        "ar-take-profit" "ar-trailing-stop" "ar-test" "ar-debug" "ar-silence"
        "ar-analyze-risk" "ar-risk-tolerance" "ar-indicator-update-delay"
        "ar-strategy" "ar-side" "ar-interval" "ar-period" "ar-market-open"
        "ar-market-close" "ar-backtrack" "ar-backtracks"
        "ar-price-movement" "ar-report-id" "ar-report-id-length"
        "ar-report-id-characters" "ar-report-location"
    )
    echo ${ARGUMENTS[@]}
}

function format_arisk_start_trading_bot_cargo_args() {
    local ARGUMENTS=(
        `format_arisk_cargo_constant_args`
        "--action start-watchdog"
        "--strategy ${MD_DEFAULT['ar-strategy']}"
        "--ticker-symbol ${MD_DEFAULT['ticker-symbol']}"
        "--base-currency ${MD_DEFAULT['base-currency']}"
        "--quote-currency ${MD_DEFAULT['exchange-currency']}"
        "--market-open ${MD_DEFAULT['ar-market-open']}"
        "--market-close ${MD_DEFAULT['ar-market-close']}"
        "--max-trades ${MD_DEFAULT['ar-max-trades']}"
        "--profit-baby ${MD_DEFAULT['ar-profit-baby']}"
        "--stop-loss ${MD_DEFAULT['ar-stop-loss']}"
        "--take-profit ${MD_DEFAULT['ar-take-profit']}"
        "--side ${MD_DEFAULT['ar-side']}"
        "--interval ${MD_DEFAULT['ar-interval']}"
        "--period ${MD_DEFAULT['ar-period']}"
        "--history-backtrack ${MD_DEFAULT['ar-backtrack']}"
        "--history-backtracks ${MD_DEFAULT['ar-backtracks']}"
        "--price-movement ${MD_DEFAULT['ar-price-movement']}"
        "--rsi-top ${MD_DEFAULT['ar-rsi-top']}"
        "--rsi-bottom ${MD_DEFAULT['ar-rsi-bottom']}"
        "--rsi-period ${MD_DEFAULT['ar-period']}"
        "--rsi-backtrack ${MD_DEFAULT['ar-rsi-backtrack']}"
        "--rsi-backtracks ${MD_DEFAULT['ar-rsi-backtracks']}"
        "--rsi-chart ${MD_DEFAULT['ar-rsi-chart']}"
        "--rsi-interval ${MD_DEFAULT['ar-rsi-interval']}"
        "--volume-movement ${MD_DEFAULT['ar-volume-movement']}"
        "--volume-interval ${MD_DEFAULT['ar-volume-interval']}"
        "--ma-period ${MD_DEFAULT['ar-ma-period']}"
        "--ma-backtrack ${MD_DEFAULT['ar-ma-backtrack']}"
        "--ma-backtracks ${MD_DEFAULT['ar-ma-backtracks']}"
        "--ma-chart ${MD_DEFAULT['ar-ma-chart']}"
        "--ma-interval ${MD_DEFAULT['ar-ma-interval']}"
        "--ema-period ${MD_DEFAULT['ar-ema-period']}"
        "--ema-backtrack ${MD_DEFAULT['ar-ema-backtrack']}"
        "--ema-backtracks ${MD_DEFAULT['ar-ema-backtracks']}"
        "--ema-chart ${MD_DEFAULT['ar-ema-chart']}"
        "--ema-interval ${MD_DEFAULT['ar-ema-interval']}"
        "--macd-backtrack ${MD_DEFAULT['ar-macd-backtrack']}"
        "--macd-backtracks ${MD_DEFAULT['ar-macd-backtracks']}"
        "--macd-chart ${MD_DEFAULT['ar-macd-chart']}"
        "--macd-fast-period ${MD_DEFAULT['ar-macd-fast-period']}"
        "--macd-slow-period ${MD_DEFAULT['ar-macd-slow-period']}"
        "--macd-signal-period ${MD_DEFAULT['ar-macd-signal-period']}"
        "--macd-interval ${MD_DEFAULT['ar-macd-interval']}"
        "--adx-period ${MD_DEFAULT['ar-adx-period']}"
        "--adx-backtrack ${MD_DEFAULT['ar-adx-backtrack']}"
        "--adx-backtracks ${MD_DEFAULT['ar-adx-backtracks']}"
        "--adx-chart ${MD_DEFAULT['ar-adx-chart']}"
        "--adx-interval ${MD_DEFAULT['ar-adx-interval']}"
        "--vwap-period ${MD_DEFAULT['ar-vwap-period']}"
        "--vwap-backtrack ${MD_DEFAULT['ar-vwap-backtrack']}"
        "--vwap-backtracks ${MD_DEFAULT['ar-vwap-backtracks']}"
        "--vwap-chart ${MD_DEFAULT['ar-vwap-chart']}"
        "--vwap-interval ${MD_DEFAULT['ar-vwap-interval']}"
        "--price-period ${MD_DEFAULT['ar-price-period']}"
        "--price-backtrack ${MD_DEFAULT['ar-price-backtrack']}"
        "--price-backtracks ${MD_DEFAULT['ar-price-backtracks']}"
        "--price-chart ${MD_DEFAULT['ar-price-chart']}"
        "--price-interval ${MD_DEFAULT['ar-price-interval']}"
        )
    echo -n "${ARGUMENTS[@]}"
    return $?
}

function format_arisk_stop_trading_bot_cargo_args() {
    local ARGUMENTS=(
        `format_arisk_cargo_constant_args`
        "--action stop-watchdog"
    )
    echo -n "${ARGUMENTS[@]}"
    return $?
}

function format_arisk_report_list_cargo_args() {
    local ARGUMENTS=(
        `format_arisk_cargo_constant_args`
        "--action list-reports"
    )
    echo -n "${ARGUMENTS[@]}"
    return $?
}

function format_arisk_report_cargo_args() {
    local ARGUMENTS=(
        `format_arisk_cargo_constant_args`
        "--action report"
    )
    echo -n "${ARGUMENTS[@]}"
    return $?
}

function format_arisk_report_trade_history_cargo_args() {
    local ARGUMENTS=(
        `format_arisk_cargo_constant_args`
        "--action trade-report"
    )
    echo -n "${ARGUMENTS[@]}"
    return $?
}

function format_arisk_report_deposit_history_cargo_args() {
    local ARGUMENTS=(
        `format_arisk_cargo_constant_args`
        "--action deposit-report"
    )
    echo -n "${ARGUMENTS[@]}"
    return $?
}

function format_arisk_report_withdrawal_history_cargo_args() {
    local ARGUMENTS=(
        `format_arisk_cargo_constant_args`
        "--action withdrawal-report"
    )
    echo -n "${ARGUMENTS[@]}"
    return $?
}

function format_arisk_view_report_cargo_args() {
    local ARGUMENTS=(
        `format_arisk_cargo_constant_args`
        "--action view-report"
        "--report-id ${MD_DEFAULT['ar-report-id']}"
    )
    echo -n "${ARGUMENTS[@]}"
    return $?
}

function format_arisk_view_market_details_cargo_args() {
    local ARGUMENTS=(
        `format_arisk_cargo_constant_args`
        "--action market-details"
    )
    echo -n "${ARGUMENTS[@]}"
    return $?
}

function format_arisk_view_account_details_cargo_args() {
    local ARGUMENTS=(
        `format_arisk_cargo_constant_args`
        "--action account-details"
    )
    echo -n "${ARGUMENTS[@]}"
    return $?
}

function format_arisk_cargo_constant_args() {
    local ARGUMENTS=(
        "--log-file ${MD_DEFAULT['log-file']}"
        "--config-file ${MD_DEFAULT['conf-dir']}/${MD_DEFAULT['ar-conf-file']}"
    )
    if [[ ${MD_DEFAULT['ar-analyze-risk']} == 'on' ]]; then
        local ARGUMENTS=(
            ${ARGUMENTS[@]} '--analyze-risk'
            "--risk-tolerance ${MD_DEFAULT['ar-risk-tolerance']}"
        )
    fi
    if [[ ${MD_DEFAULT['ar-silence']} == 'on' ]]; then
        local ARGUMENTS=( ${ARGUMENTS[@]} '--silence' )
    fi

    if [[ ${MD_DEFAULT['ar-debug']} == 'on' ]]; then
        local ARGUMENTS=( ${ARGUMENTS[@]} '--debug' )
    fi
    if [[ ${MD_DEFAULT['ar-test']} == 'on' ]]; then
        local ARGUMENTS=( ${ARGUMENTS[@]} '--test' )
    fi
    echo -n "${ARGUMENTS[@]}"
    return $?
}

function format_display_bot_ctrl_settings_args() {
    local ARGUMENTS=(
         'local-ip' 'external-ip'
    )
    echo ${ARGUMENTS[@]}
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
        'quote-currency'
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
        'base-currency' 'quote-currency' 'crypto-topx' 'quantity'
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
        "--quote-currency ${MD_DEFAULT['quote-currency']}"
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
        "--quote-currency ${MD_DEFAULT['quote-currency']}"
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

function format_ar_config_json_file_content() {
    cat<<EOF
{
    "AR_SCRIPT_NAME":                "AsymetricRisk",
    "AR_SCRIPT_DESCRIPTION":         "Crypto Trading Bot",
    "AR_VERSION":                    "AR15",
    "AR_VERSION_NO":                 "1.0",
    "_useless_yet_engaging_comment": "Tweak me babeyy!! It's the only path to enlightenment.",
    "AR_DEFAULT": {
         "project-path":             "${MD_DEFAULT['ar-project-path']}",
         "log-dir":                  "${MD_DEFAULT['log-dir']}",
         "conf-dir":                 "${MD_DEFAULT['conf-dir']}",
         "src-dir":                  "${MD_DEFAULT['src-dir']}/AsymetricRisk/src",
         "dox-dir":                  "${MD_DEFAULT['src-dir']}/AsymetricRisk/dox",
         "dta-dir":                  "${MD_DEFAULT['src-dir']}/AsymetricRisk/data",
         "log-file":                 "${MD_DEFAULT['log-file']}",
         "conf-file":                "${MD_DEFAULT['ar-conf-file']}",
         "profit-baby":              ${MD_DEFAULT['ar-profit-baby']},
         "watchdog-pid-file":        "${MD_DEFAULT['ar-watchdog-pid-file']}",
         "watchdog-anchor-file":     "${MD_DEFAULT['ar-watchdog-anchor-file']}",
         "log-format":               "${MD_DEFAULT['log-format']}",
         "timestamp-format":         "${MD_DEFAULT['timestamp-format']}",
         "api-key":                  "${MD_DEFAULT['ar-api-key']}",
         "api-secret":               "${MD_DEFAULT['ar-api-secret']}",
         "taapi-key":                "${MD_DEFAULT['ar-taapi-key']}",
         "api-url":                  "${MD_DEFAULT['ar-api-url']}",
         "taapi-url":                "${MD_DEFAULT['ar-taapi-url']}",
         "max-trades":               ${MD_DEFAULT['ar-max-trades']},
         "trading-account-type":     "${MD_DEFAULT['ar-trading-account-type']}",
         "trading-order-type":       "${MD_DEFAULT['ar-trading-order-type']}",
         "base-currency":            "${MD_DEFAULT['base-currency']}",
         "quote-currency":           "${MD_DEFAULT['quote-currency']}",
         "ticker-symbol":            "${MD_DEFAULT['ticker-symbol']}",
         "order-time-in-force":      "${MD_DEFAULT['ar-order-time-in-force']}",
         "order-response-type":      "${MD_DEFAULT['ar-order-response-type']}",
         "order-recv-window":        ${MD_DEFAULT['ar-order-recv-window']},
         "order-price":              ${MD_DEFAULT['ar-order-price']},
         "order-amount":             ${MD_DEFAULT['ar-order-amount']},
         "stop-loss":                ${MD_DEFAULT['ar-stop-loss']},
         "take-profit":              ${MD_DEFAULT['ar-take-profit']},
         "test":                     `format_config_json_flag ${MD_DEFAULT['ar-test']}`,
         "debug":                    `format_config_json_flag ${MD_DEFAULT['ar-debug']}`,
         "silence":                  `format_config_json_flag ${MD_DEFAULT['ar-silence']}`,
         "analyze-risk":             `format_config_json_flag ${MD_DEFAULT['ar-analyze-risk']}`,
         "risk-tolerance":           ${MD_DEFAULT['ar-risk-tolerance']},
         "indicator-update-delay":   ${MD_DEFAULT['ar-indicator-update-delay']},
         "strategy":                 "${MD_DEFAULT['ar-strategy']}",
         "side":                     "${MD_DEFAULT['ar-side']}",
         "interval":                 "${MD_DEFAULT['ar-interval']}",
         "period":                   ${MD_DEFAULT['ar-period']},
         "market-open":              "${MD_DEFAULT['ar-market-open']}",
         "market-close":             "${MD_DEFAULT['ar-market-close']}",
         "backtrack":                ${MD_DEFAULT['ar-backtrack']},
         "backtracks":               ${MD_DEFAULT['ar-backtracks']},
         "stop-limit":               ${MD_DEFAULT['ar-stop-limit']},
         "stop-price":               ${MD_DEFAULT['ar-stop-price']},
         "stop-limit-price":         ${MD_DEFAULT['ar-stop-limit-price']},
         "stop-limit-time-in-force": "${MD_DEFAULT['ar-stop-limit-time-in-force']}",
         "price-movement":           ${MD_DEFAULT['ar-price-movement']},
         "rsi-top":                  ${MD_DEFAULT['ar-rsi-top']},
         "rsi-bottom":               ${MD_DEFAULT['ar-rsi-bottom']},
         "rsi-period":               ${MD_DEFAULT['ar-rsi-period']},
         "rsi-backtrack":            ${MD_DEFAULT['ar-backtrack']},
         "rsi-backtracks":           ${MD_DEFAULT['ar-backtracks']},
         "rsi-chart":                "${MD_DEFAULT['ar-chart']}",
         "rsi-interval":             "${MD_DEFAULT['ar-interval']}",
         "volume-movement":          ${MD_DEFAULT['ar-volume-movement']},
         "volume-interval":          "${MD_DEFAULT['ar-volume-interval']}",
         "ma-period":                ${MD_DEFAULT['ar-ma-period']},
         "ma-backtrack":             ${MD_DEFAULT['ar-ma-backtrack']},
         "ma-backtracks":            ${MD_DEFAULT['ar-ma-backtracks']},
         "ma-chart":                 "${MD_DEFAULT['ar-ma-chart']}",
         "ma-interval":              "${MD_DEFAULT['ar-ma-interval']}",
         "ema-period":               ${MD_DEFAULT['ar-ema-period']},
         "ema-backtrack":            ${MD_DEFAULT['ar-ema-backtrack']},
         "ema-backtracks":           ${MD_DEFAULT['ar-ema-backtracks']},
         "ema-chart":                "${MD_DEFAULT['ar-ema-chart']}",
         "ema-interval":             "${MD_DEFAULT['ar-ema-interval']}",
         "macd-backtrack":           ${MD_DEFAULT['ar-macd-backtrack']},
         "macd-backtracks":          ${MD_DEFAULT['ar-macd-backtracks']},
         "macd-chart":               "${MD_DEFAULT['ar-macd-chart']}",
         "macd-fast-period":         ${MD_DEFAULT['ar-macd-fast-period']},
         "macd-slow-period":         ${MD_DEFAULT['ar-macd-slow-period']},
         "macd-signal-period":       ${MD_DEFAULT['ar-macd-signal-period']},
         "macd-interval":            "${MD_DEFAULT['ar-macd-interval']}",
         "adx-period":               ${MD_DEFAULT['ar-adx-period']},
         "adx-backtrack":            ${MD_DEFAULT['ar-adx-backtrack']},
         "adx-backtracks":           ${MD_DEFAULT['ar-adx-backtracks']},
         "adx-chart":                "${MD_DEFAULT['ar-adx-chart']}",
         "adx-interval":             "${MD_DEFAULT['ar-adx-interval']}",
         "vwap-period":              ${MD_DEFAULT['ar-vwap-period']},
         "vwap-backtrack":           ${MD_DEFAULT['ar-vwap-backtrack']},
         "vwap-backtracks":          ${MD_DEFAULT['ar-vwap-backtracks']},
         "vwap-chart":               "${MD_DEFAULT['ar-vwap-chart']}",
         "vwap-interval":            "${MD_DEFAULT['ar-vwap-interval']}",
         "price-period":             ${MD_DEFAULT['ar-price-period']},
         "price-backtrack":          ${MD_DEFAULT['ar-price-backtrack']},
         "price-backtracks":         ${MD_DEFAULT['ar-price-backtracks']},
         "price-chart":              "${MD_DEFAULT['ar-price-chart']}",
         "price-interval":           "${MD_DEFAULT['ar-price-interval']}",
         "report-id":                "${MD_DEFAULT['ar-report-id']}",
         "report-id-length":         ${MD_DEFAULT['ar-report-id-length']},
         "report-id-characters":     "${MD_DEFAULT['ar-report-id-characters']}",
         "report-location":          "${MD_DEFAULT['ar-report-location']}"
    }
}
EOF
    return $?
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
         "quote-currency":       "${MD_DEFAULT['quote-currency']}",
         "quantity":             "${MD_DEFAULT['quantity']}"
    },
    "NG_CARGO": {
        "nomads-gold":       "${MD_CARGO['nomads-gold']}"
    }
}
EOF
    return $?
}

# CODE DUMP

#       "ar-rsi-top" "ar-rsi-bottom" "ar-rsi-period" "ar-rsi-backtrack"
#       "ar-rsi-backtracks"
#       "ar-rsi-chart"
#       "ar-rsi-interval"
#       "ar-volume-movement"
#       "ar-volume-interval"
#       "ar-ma-period"
#       "ar-ma-backtrack"
#       "ar-ma-backtracks"
#       "ar-ma-chart"
#       "ar-ma-interval"
#       "ar-ema-period"
#       "ar-ema-backtrack"
#       "ar-ema-backtracks"
#       "ar-ema-chart"
#       "ar-ema-interval"
#       "ar-macd-backtrack"
#       "ar-macd-backtracks"
#       "ar-macd-chart"
#       "ar-macd-fast-period"
#       "ar-macd-slow-period"
#       "ar-macd-signal-period"
#       "ar-macd-interval"
#       "ar-adx-period"
#       "ar-adx-backtrack"
#       "ar-adx-backtracks"
#       "ar-adx-chart"
#       "ar-adx-interval"
#       "ar-vwap-period"
#       "ar-vwap-backtrack"
#       "ar-vwap-backtracks"
#       "ar-vwap-chart"
#       "ar-vwap-interval"
#       "ar-price-period"
#       "ar-price-backtrack"
#       "ar-price-backtracks"
#       "ar-price-chart"
#       "ar-price-interval"


