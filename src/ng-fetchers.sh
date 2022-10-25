#!/bin/bash
#
# Regards, the Alveare Solutions society.
#
# FETCHERS

# TODO - Add to machine dialogue
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






