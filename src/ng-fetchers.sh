#!/bin/bash
#
# Regards, the Alveare Solutions society.
#
# FETCHERS

# TODO - Add to Machine Dialogue
function fetch_file_path_from_user () {
    local PROMPT_STRING="${1:-FilePath}"
    while :
    do
        FILE_PATH=`fetch_data_from_user "$PROMPT_STRING"`
        if [ $? -ne 0 ]; then
            echo; info_msg "Aborting action."
            echo; return 1
        fi
        CHECK_VALID=`check_valid_file_path "$FILE_PATH"`
        if [ $? -ne 0 ]; then
            echo; warning_msg "Invalid file path"\
                "${RED}$FILE_PATH${RESET}."
            continue
        fi
        break
    done
    echo "$FILE_PATH"
    return 0
}

# TODO - Add to Machine Dialogue
function fetch_number_from_user() {
    PROMPT_STR="${1:-Number}"
    INT_DATA=''
    while :; do
        INT_DATA=`fetch_data_from_user "$PROMPT_STR"`
        if [ $? -ne 0 ]; then
            return 1
        fi
        check_value_is_number $INT_DATA
        if [ $? -ne 0 ]; then
            debug_msg "Value must be a number, not (${RED}$INT_DATA${RESET})."
            echo; continue
        fi; break
    done
    echo $INT_DATA
    return $?
}

function fetch_arisk_start_trading_bot_action_value_labels() {
    local LABELS=(
        "ar-conf-file" "log-file" "ar-strategy" "ticker-symbol" "base-currency"
        "exchange-currency" "ar-market-open" "ar-market-close" "ar-max-trades"
        "ar-profit-baby" "ar-stop-loss" "ar-take-profit" "ar-side" "ar-interval"
        "ar-period" "ar-history-backtracks"
    )
    local STRATEGY_LABELS=( `echo "${MD_DEFAULT['ar-strategy']}" | tr ',' ' '` )
    for label in ${STRATEGY_LABELS[@]}; do
        if [[ "${label}" == 'price' ]]; then
            local LABELS=( ${LABELS[@]} 'ar-price-movement' 'ar-volume-movement' )
        fi
        if [[ "${label}" == 'volume' ]] \
                && [[ `echo ${LABELS[@]} | grep 'ar-price-movement' &>/dev/null; echo $?` == '1' ]]; then
            local LABELS=( ${LABELS[@]} 'ar-volume-movement' )
        fi
        if [[ "${label}" == 'rsi' ]]; then
            local LABELS=( ${LABELS[@]} 'ar-rsi-top' 'ar-rsi-bottom' )
        fi
        if [[ "${label}" == 'macd' ]]; then
            local LABELS=(
                ${LABELS[@]} "ar-macd-fast-period" "ar-macd-slow-period"
                "ar-macd-signal-period"
            )
        fi
    done
    echo -n ${LABELS[@]}
    return $?
}

function fetch_arisk_stop_trading_bot_action_value_labels() {
    local LABELS=(
        "ar-conf-file" "log-file" "ar-silence" "ar-debug" "ar-test"
        "ar-watchdog-anchor-file" "ar-watchdog-pid-file"
    )
    echo -n ${LABELS[@]}
    return $?
}

function fetch_arisk_report_list_action_value_labels() {
    local LABELS=(
        "ar-conf-file" "log-file" "ar-silence" "ar-debug" "ar-test"
    )
    echo -n ${LABELS[@]}
    return $?
}

function fetch_arisk_report_action_value_labels() {
    local LABELS=(
        "ar-conf-file" "log-file" "ar-silence" "ar-debug" "ar-test"
        "ar-report-id-length" "ar-report-id-characters" "ar-report-location"
    )
    echo -n ${LABELS[@]}
    return $?
}

function fetch_arisk_report_trade_history_action_value_labels() {
    local LABELS=(
        "ar-conf-file" "log-file" "ar-silence" "ar-debug" "ar-test"
    )
    echo -n ${LABELS[@]}
    return $?
}

function fetch_arisk_report_deposit_history_action_value_labels() {
    local LABELS=(
        "ar-conf-file" "log-file" "ar-silence" "ar-debug" "ar-test"
    )
    echo -n ${LABELS[@]}
    return $?
}

function fetch_arisk_report_withdrawal_history_action_value_labels() {
    local LABELS=(
        "ar-conf-file" "log-file" "ar-silence" "ar-debug" "ar-test"
    )
    echo -n ${LABELS[@]}
    return $?
}

function fetch_arisk_view_report_action_value_labels() {
    local LABELS=(
        "ar-conf-file" "log-file" "ar-silence" "ar-debug" "ar-test"
        "ar-report-id"
    )
    echo -n ${LABELS[@]}
    return $?
}

function fetch_arisk_view_market_details_action_value_labels() {
    local LABELS=(
        "ar-conf-file" "log-file" "ar-silence" "ar-debug" "ar-test"
        "base-currency" "exchange-currency"
    )
    echo -n ${LABELS[@]}
    return $?
}

function fetch_arisk_view_account_details_action_value_labels() {
    local LABELS=(
        "ar-conf-file" "log-file" "ar-silence" "ar-debug" "ar-test"
        "base-currency" "exchange-currency"
    )
    echo -n ${LABELS[@]}
    return $?
}

function fetch_valid_ar_risk_tolerance_levels() {
    local LEVELS=( 'Low' 'Low-Mid' 'Mid' 'Mid-High' 'High' )
    echo -n ${LEVELS[@]}
    return $?
}

function fetch_valid_ar_sides() {
    local SIDES=( 'buy' 'sell' 'auto' )
    echo -n ${SIDES[@]}
    return $?
}

function fetch_valid_ar_intervals() {
    local INTERVALS=( '1m' '5m' '15m' '30m' '1h' '2h' '4h' '12h' '1d' '1w' )
    echo -n ${INTERVALS[@]}
    return $?
}

function fetch_ng_cargo_action_labels() {
    local LABELS=(
        'setup' 'price-history' 'recommendations' 'stock-info' 'price-open'
        'price-close' 'price-high' 'price-low' 'volume' 'company-calendar'
        'show-currencies' 'show-crypto' 'crypto-topx' 'currency-chart'
        'currency-convertor'
    )
    echo -n ${LABELS[@]}
    return $?
}

function fetch_show_company_calendar_action_value_labels() {
    local LABELS=( 'action' 'action-target' 'conf-json-file' 'log-file' )
    echo -n ${LABELS[@]}
    return $?
}

function fetch_show_stock_volume_action_value_labels() {
    local LABELS=(
        'action' 'action-target' 'conf-json-file' 'log-file' 'ticker-symbol'
        'period' 'period-interval' 'period-start' 'period-end'
    )
    echo -n ${LABELS[@]}
    return $?
}

function fetch_show_stock_price_low_action_value_labels() {
    local LABELS=(
        'action' 'action-target' 'conf-json-file' 'log-file' 'ticker-symbol'
        'period' 'period-interval' 'period-start' 'period-end'
    )
    echo -n ${LABELS[@]}
    return $?
}

function fetch_show_stock_price_high_action_value_labels() {
    local LABELS=(
        'action' 'action-target' 'conf-json-file' 'log-file' 'ticker-symbol'
        'period' 'period-interval' 'period-start' 'period-end'
    )
    echo -n ${LABELS[@]}
    return $?
}

function fetch_show_stock_price_close_action_value_labels() {
    local LABELS=(
        'action' 'action-target' 'conf-json-file' 'log-file' 'ticker-symbol'
        'period' 'period-interval' 'period-start' 'period-end'
    )
    echo -n ${LABELS[@]}
    return $?
}

function fetch_show_stock_price_open_action_value_labels() {
    local LABELS=(
        'action' 'action-target' 'conf-json-file' 'log-file' 'ticker-symbol'
        'period' 'period-interval' 'period-start' 'period-end'
    )
    echo -n ${LABELS[@]}
    return $?
}

function fetch_show_stock_info_action_value_labels() {
    local LABELS=(
        'action' 'action-target' 'conf-json-file' 'log-file' 'ticker-symbol'
    )
    echo -n ${LABELS[@]}
    return $?
}

function fetch_show_stock_recommendations_action_value_labels() {
    local LABELS=(
        'action' 'action-target' 'conf-json-file' 'log-file' 'ticker-symbol'
    )
    echo -n ${LABELS[@]}
    return $?
}

function fetch_show_stock_price_history_action_value_labels() {
    local LABELS=(
        'action' 'action-target' 'conf-json-file' 'log-file' 'ticker-symbol'
        'period' 'period-interval' 'period-start' 'period-end'
    )
    echo -n ${LABELS[@]}
    return $?
}

function fetch_currency_convertor_action_value_labels() {
    local LABELS=(
        'action' 'action-target' 'conf-json-file' 'log-file' 'base-currency'
        'exchange-currency' 'quantity'
    )
    echo -n ${LABELS[@]}
    return $?
}

function fetch_show_currency_chart_action_value_labels() {
    local LABELS=(
        'action' 'action-target' 'conf-json-file' 'log-file' 'base-currency'
        'exchange-currency' 'period' 'period-interval' 'period-start' 'period-end'
    )
    echo -n ${LABELS[@]}
    return $?
}

function fetch_show_crypto_topx_action_value_labels() {
    local LABELS=(
        'action' 'action-target' 'conf-json-file' 'log-file' 'crypto-topx'
        'base-currency' 'period' 'period-interval' 'period-start' 'period-end'
    )
    echo -n ${LABELS[@]}
    return $?
}

function fetch_show_supported_currencies_action_value_labels() {
    local LABELS=( 'action' 'action-target'  'conf-json-file' 'log-file' )
    echo -n ${LABELS[@]}
    return $?
}

function fetch_show_supported_crypto_action_value_labels() {
    local LABELS=( 'action' 'action-target' 'conf-json-file' 'log-file' )
    echo -n ${LABELS[@]}
    return $?
}






