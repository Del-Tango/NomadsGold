#!/bin/bash
#
# Regards, the Alveare Solutions #!/Society -x
#
# ACTIONS

function action_nomadsgold_cargo() {
    local ARGUMENTS=( $@ )
    trap 'trap - SIGINT; echo ''[ SIGINT ]: Aborting action.''; return 0' SIGINT
    echo; ${NG_CARGO['nomads-gold']} ${ARGUMENTS[@]} 2> /dev/null; trap - SIGINT
    return $?
}

function action_crypto_topx() {
    local ARGUMENTS=( `format_crypto_topx_cargo_args` )
    local ACTION_VALUES=( `fetch_show_crypto_topx_action_value_labels` )
    set_action 'crypto-topx'; set_action_target 'crypto'
    confirm_loaded_action_values_with_user ${ACTION_VALUES[@]}
    debug_msg "Executing: (./`basename ${NG_CARGO['nomads-gold']}` ${ARGUMENTS[@]})"
    action_nomadsgold_cargo ${ARGUMENTS[@]}
    return $?
}

function action_currency_chart() {
    local ARGUMENTS=( `format_currency_chart_cargo_args` )
    local ACTION_VALUES=( `fetch_show_currency_chart_action_value_labels` )
    set_action 'currency-chart'; set_action_target 'currency'
    confirm_loaded_action_values_with_user ${ACTION_VALUES[@]}
    debug_msg "Executing: (./`basename ${NG_CARGO['nomads-gold']}` ${ARGUMENTS[@]})"
    action_nomadsgold_cargo ${ARGUMENTS[@]}
    return $?
}

function action_currency_convertor() {
    local ARGUMENTS=( `format_currency_convertor_cargo_args` )
    local ACTION_VALUES=( `fetch_currency_convertor_action_value_labels` )
    set_action 'currency-convertor'; set_action_target 'currency'
    confirm_loaded_action_values_with_user ${ACTION_VALUES[@]}
    debug_msg "Executing: (./`basename ${NG_CARGO['nomads-gold']}` ${ARGUMENTS[@]})"
    action_nomadsgold_cargo ${ARGUMENTS[@]}
    return $?
}

function action_stock_price_history() {
    local ARGUMENTS=( `format_stock_price_history_cargo_args` )
    local ACTION_VALUES=( `fetch_show_stock_price_history_action_value_labels` )
    set_action 'price-history'; set_action_target 'stock'
    confirm_loaded_action_values_with_user ${ACTION_VALUES[@]}
    debug_msg "Executing: (./`basename ${NG_CARGO['nomads-gold']}` ${ARGUMENTS[@]})"
    action_nomadsgold_cargo ${ARGUMENTS[@]}
    return $?
}

function action_stock_recommendations() {
    local ARGUMENTS=( `format_stock_recommendations_cargo_args` )
    local ACTION_VALUES=( `fetch_show_stock_recommendations_action_value_labels` )
    set_action 'recommendations'; set_action_target 'stock'
    confirm_loaded_action_values_with_user ${ACTION_VALUES[@]}
    debug_msg "Executing: (./`basename ${NG_CARGO['nomads-gold']}` ${ARGUMENTS[@]})"
    action_nomadsgold_cargo ${ARGUMENTS[@]}
    return $?
}

function action_stock_info() {
    local ARGUMENTS=( `format_stock_info_cargo_args` )
    local ACTION_VALUES=( `fetch_show_stock_info_action_value_labels` )
    set_action 'stock-info'; set_action_target 'stock'
    confirm_loaded_action_values_with_user ${ACTION_VALUES[@]}
    debug_msg "Executing: (./`basename ${NG_CARGO['nomads-gold']}` ${ARGUMENTS[@]})"
    action_nomadsgold_cargo ${ARGUMENTS[@]}
    return $?
}

function action_stock_price_open() {
    local ARGUMENTS=( `format_stock_price_open_cargo_args` )
    local ACTION_VALUES=( `fetch_show_stock_price_open_action_value_labels` )
    set_action 'price-open'; set_action_target 'stock'
    confirm_loaded_action_values_with_user ${ACTION_VALUES[@]}
    debug_msg "Executing: (./`basename ${NG_CARGO['nomads-gold']}` ${ARGUMENTS[@]})"
    action_nomadsgold_cargo ${ARGUMENTS[@]}
    return $?
}

function action_stock_price_close() {
    local ARGUMENTS=( `format_stock_price_close_cargo_args` )
    local ACTION_VALUES=( `fetch_show_stock_price_close_action_value_labels` )
    set_action 'price-close'; set_action_target 'stock'
    confirm_loaded_action_values_with_user ${ACTION_VALUES[@]}
    debug_msg "Executing: (./`basename ${NG_CARGO['nomads-gold']}` ${ARGUMENTS[@]})"
    action_nomadsgold_cargo ${ARGUMENTS[@]}
    return $?
}

function action_stock_price_high() {
    local ARGUMENTS=( `format_stock_price_high_cargo_args` )
    local ACTION_VALUES=( `fetch_show_stock_price_high_action_value_labels` )
    set_action 'price-high'; set_action_target 'stock'
    confirm_loaded_action_values_with_user ${ACTION_VALUES[@]}
    debug_msg "Executing: (./`basename ${NG_CARGO['nomads-gold']}` ${ARGUMENTS[@]})"
    action_nomadsgold_cargo ${ARGUMENTS[@]}
    return $?
}

function action_stock_price_low() {
    local ARGUMENTS=( `format_stock_price_low_cargo_args` )
    local ACTION_VALUES=( `fetch_show_stock_price_low_action_value_labels` )
    set_action 'price-low'; set_action_target 'stock'
    confirm_loaded_action_values_with_user ${ACTION_VALUES[@]}
    debug_msg "Executing: (./`basename ${NG_CARGO['nomads-gold']}` ${ARGUMENTS[@]})"
    action_nomadsgold_cargo ${ARGUMENTS[@]}
    return $?
}

function action_stock_volume() {
    local ARGUMENTS=( `format_stock_volume_cargo_args` )
    local ACTION_VALUES=( `fetch_show_stock_volume_action_value_labels` )
    set_action 'volume'; set_action_target 'stock'
    confirm_loaded_action_values_with_user ${ACTION_VALUES[@]}
    debug_msg "Executing: (./`basename ${NG_CARGO['nomads-gold']}` ${ARGUMENTS[@]})"
    action_nomadsgold_cargo ${ARGUMENTS[@]}
    return $?
}

function action_company_calendar() {
    local ARGUMENTS=( `format_company_calendar_cargo_args` )
    local ACTION_VALUES=( `fetch_show_company_calendar_action_value_labels` )
    set_action 'company-calendar'; set_action_target 'currency'
    confirm_loaded_action_values_with_user ${ACTION_VALUES[@]}
    debug_msg "Executing: (./`basename ${NG_CARGO['nomads-gold']}` ${ARGUMENTS[@]})"
    action_nomadsgold_cargo ${ARGUMENTS[@]}
    return $?
}

function action_show_supported_currencies() {
    local ARGUMENTS=( `format_show_supported_currencies_cargo_args` )
    local ACTION_VALUES=( `fetch_show_supported_currencies_action_value_labels` )
    set_action 'show-currencies'; set_action_target 'currency'
    confirm_loaded_action_values_with_user ${ACTION_VALUES[@]}
    debug_msg "Executing: (./`basename ${NG_CARGO['nomads-gold']}` ${ARGUMENTS[@]})"
    action_nomadsgold_cargo ${ARGUMENTS[@]}
    return $?
}

function action_show_supported_crypto() {
    local ARGUMENTS=( `format_show_supported_crypto_cargo_args` )
    local ACTION_VALUES=( `fetch_show_supported_crypto_action_value_labels` )
    set_action 'show-crypto'; set_action_target 'crypto'
    confirm_loaded_action_values_with_user ${ACTION_VALUES[@]}
    debug_msg "Executing: (./`basename ${NG_CARGO['nomads-gold']}` ${ARGUMENTS[@]})"
    action_nomadsgold_cargo ${ARGUMENTS[@]}
    return $?
}

function action_setup_machine() {
    local ARGUMENTS=( `format_setup_machine_cargo_arguments` )
    local EXEC_STR="~$ ./`basename ${NG_CARGO['nomads-gold']}` ${ARGUMENTS[@]}"
    echo; info_msg "About to execute (${MAGENTA}${EXEC_STR}${RESET})"
    fetch_ultimatum_from_user "Are you sure about this? ${YELLOW}Y/N${RESET}"
    if [ $? -ne 0 ]; then
        info_msg "Aborting action."
        return 0
    fi
    debug_msg "Executing: (./`basename ${NG_CARGO['nomads-gold']}` ${ARGUMENTS[@]})"
    action_nomadsgold_cargo ${ARGUMENTS[@]}
    return $?
}

function action_set_cargo_action() {
    local OPTIONS=( `fetch_ng_cargo_action_labels` )
    echo; warning_msg "This action should not be taken manually! But we consider you to be a big boy/girl now, so go ahead ^^"
    while :; do
        info_msg "Select action or ${MAGENTA}Back${RESET}.
        "
        TARGET=`fetch_selection_from_user 'Action' ${OPTIONS[@]}`
        if [ $? -ne 0 ]; then
            echo; info_msg "Aborting action."
            return 1
        fi
        break
    done
    set_action "$ACTION"
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set (${RED}$SCRIPT_NAME${RESET}) action"\
            "to (${RED}$ACTION${RESET})."
    else
        ok_msg "Succesfully set (${BLUE}$SCRIPT_NAME${RESET}) action"\
            "to (${GREEN}$ACTION${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_cargo_action_target() {
    local OPTIONS=( 'stock' 'currency' 'crypto' )
    echo; warning_msg "This action should not be taken manually! But we consider you to be a big boy/girl now, so go ahead ^^"
    while :; do
        info_msg "Select action target or ${MAGENTA}Back${RESET}.
        "
        TARGET=`fetch_selection_from_user 'Target' ${OPTIONS[@]}`
        if [ $? -ne 0 ]; then
            echo; info_msg "Aborting action."
            return 1
        fi
        break
    done
    set_action_target "$TARGET"
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set (${RED}$SCRIPT_NAME${RESET}) action target"\
            "to (${RED}$TARGET${RESET})."
    else
        ok_msg "Succesfully set (${BLUE}$SCRIPT_NAME${RESET}) action target"\
            "to (${GREEN}$TARGET${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_quantity() {
    echo; info_msg "Setting currency quantity -"
    info_msg "Type quantity or (${MAGENTA}.back${RESET})."
    local QUANTITY=`fetch_number_from_user 'Quantity'`
    if [ $? -ne 0 ] || [ -z "$QUANTITY" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_quantity $QUANTITY
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set quantity (${RED}$QUANTITY${RESET})"
    else
        ok_msg "Successfully set quantity (${GREEN}$QUANTITY${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_stock_symbol() {
    echo; info_msg "Setting ${BLUE}$SCRIPT_NAME${RESET} stock symbol -"
    info_msg "Type stock symbol or (${MAGENTA}.back${RESET})."
    local STOCK=`fetch_data_from_user 'Stock'`
    if [ $? -ne 0 ] || [ -z "$STOCK" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_stock_symbol "$STOCK"
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set stock symbol (${RED}$STOCK${RESET})"
    else
        ok_msg "Successfully set stock symbol (${GREEN}$STOCK${RESET})"
    fi
    return $EXIT_CODE
}

function action_set_base_currency() {
    echo; info_msg "Setting ${BLUE}$SCRIPT_NAME${RESET} base currency -"
    info_msg "Type base currency symbol or (${MAGENTA}.back${RESET})."
    local CURRENCY=`fetch_data_from_user '(B)Currency'`
    if [ $? -ne 0 ] || [ -z "$CURRENCY" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_base_currency "$CURRENCY"
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set base currency (${RED}$CURRENCY${RESET})"
    else
        ok_msg "Successfully set base currency (${GREEN}$CURRENCY${RESET})"
    fi
    return $EXIT_CODE
}

function action_set_exchange_currency() {
    echo; info_msg "Setting ${BLUE}$SCRIPT_NAME${RESET} exchange currency -"
    info_msg "Type exchange currency symbol or (${MAGENTA}.back${RESET})."
    local CURRENCY=`fetch_data_from_user '(E)Currency'`
    if [ $? -ne 0 ] || [ -z "$CURRENCY" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_exchange_currency "$CURRENCY"
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set exchange currency (${RED}$CURRENCY${RESET})"
    else
        ok_msg "Successfully set exchange currency (${GREEN}$CURRENCY${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_watch_interval() {
    echo; info_msg "Setting watch process update interval (seconds) -"
    info_msg "Type number of seconds or (${MAGENTA}.back${RESET})."
    local SECONDS=`fetch_number_from_user 'Seconds'`
    if [ $? -ne 0 ] || [ -z "$SECONDS" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_watch_interval $SECONDS
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set watch interval (${RED}$SECONDS${RESET})"
    else
        ok_msg "Successfully set watch interval (${GREEN}$SECONDS${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_watch_anchor_file() {
    echo; info_msg "Setting watch process anchor file -"
    info_msg "Type absolute file path or (${MAGENTA}.back${RESET})."
    local FILE_PATH=`fetch_file_path_from_user 'FilePath'`
    if [ $? -ne 0 ] || [ -z "$FILE_PATH" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_watch_anchor_file "$FILE_PATH"
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set (${RED}$FILE_PATH${RESET}) as"\
            "(${BLUE}$SCRIPT_NAME${RESET}) watch anchor file."
    else
        ok_msg "Successfully set watch anchor file (${GREEN}$FILE_PATH${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_period() {
    echo; info_msg "Setting ${BLUE}$SCRIPT_NAME${RESET} period -"
    info_msg "Type interval (1d | 5d | 1w | 3mo | 1y | ytd | max ) or (${MAGENTA}.back${RESET})."
    local PERIOD=`fetch_data_from_user 'Period'`
    if [ $? -ne 0 ] || [ -z "$DATE" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_period "$PERIOD"
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set period (${RED}$PERIOD${RESET})"
    else
        ok_msg "Successfully set period (${GREEN}$PERIOD${RESET})"
    fi
    return $EXIT_CODE
}

function action_set_period_interval() {
    echo; info_msg "Setting ${BLUE}$SCRIPT_NAME${RESET} period interval -"
    info_msg "Type interval (1d | 5d | 1w | 3mo | 1y ) or (${MAGENTA}.back${RESET})."
    local INTERVAL=`fetch_data_from_user 'Interval'`
    if [ $? -ne 0 ] || [ -z "$DATE" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_period_interval $INTERVAL
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set period interval (${RED}$INTERVAL${RESET})"
    else
        ok_msg "Successfully set period interval (${GREEN}$INTERVAL${RESET})"
    fi
    return $EXIT_CODE
}

function action_set_period_start() {
    echo; info_msg "Setting ${BLUE}$SCRIPT_NAME${RESET} period start date -"
    info_msg "Type date (YYYYY-MM-DD) or (${MAGENTA}.back${RESET})."
    local DATE=`fetch_data_from_user 'Date'`
    if [ $? -ne 0 ] || [ -z "$DATE" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_period_start_date $DATE
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set period start date (${RED}$DATE${RESET})"
    else
        ok_msg "Successfully set period start date (${GREEN}$DATE${RESET})"
    fi
    return $EXIT_CODE
}

function action_set_period_end() {
    echo; info_msg "Setting ${BLUE}$SCRIPT_NAME${RESET} period end date -"
    info_msg "Type date (YYYYY-MM-DD) or (${MAGENTA}.back${RESET})."
    local DATE=`fetch_data_from_user 'Date'`
    if [ $? -ne 0 ] || [ -z "$DATE" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_period_end_date $DATE
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set period end date (${RED}$DATE${RESET})"
    else
        ok_msg "Successfully set period end date (${GREEN}$DATE${RESET})"
    fi
    return $EXIT_CODE
}

function action_set_out_file() {
    echo; info_msg "Setting action out file -"
    info_msg "Type absolute file path or (${MAGENTA}.back${RESET})."
    local FILE_PATH=`fetch_file_path_from_user 'FilePath'`
    if [ $? -ne 0 ] || [ -z "$FILE_PATH" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_out_file "$FILE_PATH"
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set (${RED}$FILE_PATH${RESET}) as"\
            "(${BLUE}$SCRIPT_NAME${RESET}) out file."
    else
        ok_msg "Successfully set out file (${GREEN}$FILE_PATH${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_crypto_topx() {
    echo; info_msg "Setting cargo action Crypto TopX value -"
    info_msg "Type number of top crypto coins or (${MAGENTA}.back${RESET})."
    local CTOPX=`fetch_number_from_user 'CTopX'`
    if [ $? -ne 0 ] || [ -z "$CTOPX" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_crypto_topx $CTOP
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set Crypto TopX (${RED}$CTOPX${RESET})"
    else
        ok_msg "Successfully set Crypto TopX (${GREEN}$CTOPX${RESET})"
    fi
    return $EXIT_CODE
}

function action_set_write_mode() {
    local OPTIONS=( 'write' 'append' )
    echo; while :
    do
        info_msg "Select out file write mode or ${MAGENTA}Back${RESET}.
        "
        MODE=`fetch_selection_from_user 'WMode' ${OPTIONS[@]}`
        if [ $? -ne 0 ]; then
            echo; info_msg "Aborting action."
            return 1
        fi
        break
    done
    set_write_mode "$MODE"
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set (${RED}$SCRIPT_NAME${RESET}) out file write mode"\
            "to (${RED}$MODE${RESET})."
    else
        ok_msg "Succesfully set (${BLUE}$SCRIPT_NAME${RESET}) out file write mode"\
            "to (${GREEN}$MODE${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_action_target() {
    local OPTIONS=( 'stock' 'currency' 'crypto' )
    echo; while :
    do
        info_msg "Select cargo action target or ${MAGENTA}Back${RESET}.
        "
        TARGET=`fetch_selection_from_user 'ATarget' ${OPTIONS[@]}`
        if [ $? -ne 0 ]; then
            echo; info_msg "Aborting action."
            return 1
        fi
        break
    done
    set_action_target "$TARGET"
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set (${RED}$SCRIPT_NAME${RESET}) cargo script action target"\
            "to (${RED}$TARGET${RESET})."
    else
        ok_msg "Succesfully set (${BLUE}$SCRIPT_NAME${RESET}) cargo script action target"\
            "to (${GREEN}$TARGET${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_write_off() {
    echo; fetch_ultimatum_from_user \
        "${YELLOW}Are you sure about this? Y/N${RESET}"
    if [ $? -ne 0 ]; then
        echo; info_msg "Aborting action."
        return 1
    fi
    set_write_flag 'off'
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set (${RED}$SCRIPT_NAME${RESET}) write flag"\
            "to (${RED}OFF${RESET})."
    else
        ok_msg "Succesfully set (${BLUE}$SCRIPT_NAME${RESET}) write flag"\
            "to (${RED}OFF${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_write_on() {
    echo; fetch_ultimatum_from_user \
        "${YELLOW}Are you sure about this? Y/N${RESET}"
    if [ $? -ne 0 ]; then
        echo; info_msg "Aborting action."
        return 1
    fi
    set_write_flag 'on'
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set (${RED}$SCRIPT_NAME${RESET}) write flag"\
            "to (${GREEN}ON${RESET})."
    else
        ok_msg "Succesfully set (${BLUE}$SCRIPT_NAME${RESET}) write flag"\
            "to (${GREEN}ON${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_action_header_off() {
    echo; fetch_ultimatum_from_user \
        "${YELLOW}Are you sure about this? Y/N${RESET}"
    if [ $? -ne 0 ]; then
        echo; info_msg "Aborting action."
        return 1
    fi
    set_action_header_flag 'off'
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set (${RED}$SCRIPT_NAME${RESET}) action header flag"\
            "to (${RED}OFF${RESET})."
    else
        ok_msg "Succesfully set (${BLUE}$SCRIPT_NAME${RESET}) action header flag"\
            "to (${RED}OFF${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_action_header_on() {
    echo; fetch_ultimatum_from_user \
        "${YELLOW}Are you sure about this? Y/N${RESET}"
    if [ $? -ne 0 ]; then
        echo; info_msg "Aborting action."
        return 1
    fi
    set_action_header_flag 'on'
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set (${RED}$SCRIPT_NAME${RESET}) action_header flag"\
            "to (${GREEN}ON${RESET})."
    else
        ok_msg "Succesfully set (${BLUE}$SCRIPT_NAME${RESET}) action header flag"\
            "to (${GREEN}ON${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_watch_off() {
    echo; fetch_ultimatum_from_user \
        "${YELLOW}Are you sure about this? Y/N${RESET}"
    if [ $? -ne 0 ]; then
        echo; info_msg "Aborting action."
        return 1
    fi
    set_watch_flag 'off'
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set (${RED}$SCRIPT_NAME${RESET}) watch flag"\
            "to (${RED}OFF${RESET})."
    else
        ok_msg "Succesfully set (${BLUE}$SCRIPT_NAME${RESET}) watch flag"\
            "to (${RED}OFF${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_watch_on() {
    echo; fetch_ultimatum_from_user \
        "${YELLOW}Are you sure about this? Y/N${RESET}"
    if [ $? -ne 0 ]; then
        echo; info_msg "Aborting action."
        return 1
    fi
    set_watch_flag 'on'
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set (${RED}$SCRIPT_NAME${RESET}) watch flag"\
            "to (${GREEN}ON${RESET})."
    else
        ok_msg "Succesfully set (${BLUE}$SCRIPT_NAME${RESET}) watch flag"\
            "to (${GREEN}ON${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_watch_flag() {
    echo; case "$NG_DEFAULT['silence']" in
        'on'|'On'|'ON')
            info_msg "Watch is (${GREEN}ON${RESET}), switching to (${RED}OFF${RESET}) -"
            action_set_watch_off
            ;;
        'off'|'Off'|'OFF')
            info_msg "Watch is (${RED}OFF${RESET}), switching to (${GREEN}ON${RESET}) -"
            action_set_watch_on
            ;;
        *)
            info_msg "Watch not set, switching to (${GREEN}OFF${RESET}) -"
            action_set_watch_off
            ;;
    esac
    return $?
}

function action_set_write_flag() {
    echo; case "$NG_DEFAULT['silence']" in
        'on'|'On'|'ON')
            info_msg "Write is (${GREEN}ON${RESET}), switching to (${RED}OFF${RESET}) -"
            action_set_write_off
            ;;
        'off'|'Off'|'OFF')
            info_msg "Write is (${RED}OFF${RESET}), switching to (${GREEN}ON${RESET}) -"
            action_set_write_on
            ;;
        *)
            info_msg "Write flag not set, switching to (${GREEN}OFF${RESET}) -"
            action_set_write_off
            ;;
    esac
    return $?
}

function action_set_action_header_flag() {
    echo; case "$NG_DEFAULT['silence']" in
        'on'|'On'|'ON')
            info_msg "Action Header is (${GREEN}ON${RESET}), switching to (${RED}OFF${RESET}) -"
            action_set_action_header_off
            ;;
        'off'|'Off'|'OFF')
            info_msg "Action Header is (${RED}OFF${RESET}), switching to (${GREEN}ON${RESET}) -"
            action_set_action_header_on
            ;;
        *)
            info_msg "Action Header flag not set, switching to (${GREEN}OFF${RESET}) -"
            action_set_action_header_off
            ;;
    esac
    return $?
}

function action_set_silence_off() {
    echo; fetch_ultimatum_from_user \
        "${YELLOW}Are you sure about this? Y/N${RESET}"
    if [ $? -ne 0 ]; then
        echo; info_msg "Aborting action."
        return 1
    fi
    set_silence_flag 'off'
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set (${RED}$SCRIPT_NAME${RESET}) debug"\
            "to (${RED}OFF${RESET})."
    else
        ok_msg "Succesfully set (${BLUE}$SCRIPT_NAME${RESET}) debug"\
            "to (${RED}OFF${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_silence_on() {
    echo; fetch_ultimatum_from_user \
        "${YELLOW}Are you sure about this? Y/N${RESET}"
    if [ $? -ne 0 ]; then
        echo; info_msg "Aborting action."
        return 1
    fi
    set_silence_flag 'on'
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set (${RED}$SCRIPT_NAME${RESET}) debug"\
            "to (${GREEN}ON${RESET})."
    else
        ok_msg "Succesfully set (${BLUE}$SCRIPT_NAME${RESET}) debug"\
            "to (${GREEN}ON${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_silence_flag() {
    echo; case "$NG_DEFAULT['silence']" in
        'on'|'On'|'ON')
            info_msg "Silence is (${GREEN}ON${RESET}), switching to (${RED}OFF${RESET}) -"
            action_set_silence_off
            ;;
        'off'|'Off'|'OFF')
            info_msg "Silence is (${RED}OFF${RESET}), switching to (${GREEN}ON${RESET}) -"
            action_set_silence_on
            ;;
        *)
            info_msg "Silence not set, switching to (${GREEN}OFF${RESET}) -"
            action_set_silence_off
            ;;
    esac
    return $?
}

function action_set_config_file() {
    echo; info_msg "Setting config file -"
    info_msg "Type absolute file path or (${MAGENTA}.back${RESET})."
    local FILE_PATH=`fetch_file_path_from_user 'FilePath'`
    if [ $? -ne 0 ] || [ -z "$FILE_PATH" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_config_file "$FILE_PATH"
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set (${RED}$FILE_PATH${RESET}) as"\
            "(${BLUE}$SCRIPT_NAME${RESET}) config file."
    else
        ok_msg "Successfully set config file (${GREEN}$FILE_PATH${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_config_json_file() {
    echo; info_msg "Setting JSON config file -"
    info_msg "Type absolute file path or (${MAGENTA}.back${RESET})."
    local FILE_PATH=`fetch_file_path_from_user 'FilePath'`
    if [ $? -ne 0 ] || [ -z "$FILE_PATH" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_json_config_file "$FILE_PATH"
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set (${RED}$FILE_PATH${RESET}) as"\
            "(${BLUE}$SCRIPT_NAME${RESET}) JSON config file."
    else
        ok_msg "Successfully set JSON config file (${GREEN}$FILE_PATH${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_wpa_supplicant_file() {
    echo; info_msg "Setting system wpa_supplicant config file -"
    info_msg "Type absolute file path or (${MAGENTA}.back${RESET})."
    local FILE_PATH=`fetch_file_path_from_user 'FilePath'`
    if [ $? -ne 0 ] || [ -z "$FILE_PATH" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_system_wpa_supplicant_file "$FILE_PATH"
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set (${RED}$FILE_PATH${RESET}) as"\
            "(${BLUE}$SCRIPT_NAME${RESET}) system wpa_supplicant config file."
    else
        ok_msg "Successfully set system wpa_supplicant config file (${GREEN}$FILE_PATH${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_bashrc_file() {
    echo; info_msg "Setting user .bashrc file -"
    info_msg "Type absolute file path or (${MAGENTA}.back${RESET})."
    local FILE_PATH=`fetch_file_path_from_user 'FilePath'`
    if [ $? -ne 0 ] || [ -z "$FILE_PATH" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_user_bashrc_file "$FILE_PATH"
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set (${RED}$FILE_PATH${RESET}) as"\
            "(${BLUE}$SCRIPT_NAME${RESET}) user bashrc file."
    else
        ok_msg "Successfully set user bashrc file (${GREEN}$FILE_PATH${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_bashrc_template_file() {
    echo; info_msg "Setting user .bashrc template file -"
    info_msg "Type absolute file path or (${MAGENTA}.back${RESET})."
    local FILE_PATH=`fetch_file_path_from_user 'FilePath'`
    if [ $? -ne 0 ] || [ -z "$FILE_PATH" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_user_bashrc_template_file "$FILE_PATH"
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set (${RED}$FILE_PATH${RESET}) as"\
            "(${BLUE}$SCRIPT_NAME${RESET}) user bashrc template file."
    else
        ok_msg "Successfully set user bashrc template file (${GREEN}$FILE_PATH${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_bashaliases_file() {
    echo; info_msg "Setting user .bash_aliases file -"
    info_msg "Type absolute file path or (${MAGENTA}.back${RESET})."
    local FILE_PATH=`fetch_file_path_from_user 'FilePath'`
    if [ $? -ne 0 ] || [ -z "$FILE_PATH" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_user_bash_aliases_file "$FILE_PATH"
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set (${RED}$FILE_PATH${RESET}) as"\
            "(${BLUE}$SCRIPT_NAME${RESET}) user bash aliases file."
    else
        ok_msg "Successfully set user bash aliases file (${GREEN}$FILE_PATH${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_hostname_file() {
    echo; info_msg "Setting system hostname file -"
    info_msg "Type absolute file path or (${MAGENTA}.back${RESET})."
    local FILE_PATH=`fetch_file_path_from_user 'FilePath'`
    if [ $? -ne 0 ] || [ -z "$FILE_PATH" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_system_hostname_file "$FILE_PATH"
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set (${RED}$FILE_PATH${RESET}) as"\
            "(${BLUE}$SCRIPT_NAME${RESET}) system hostname file."
    else
        ok_msg "Successfully set system hostname file (${GREEN}$FILE_PATH${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_hosts_file() {
    echo; info_msg "Setting system hosts file -"
    info_msg "Type absolute file path or (${MAGENTA}.back${RESET})."
    local FILE_PATH=`fetch_file_path_from_user 'FilePath'`
    if [ $? -ne 0 ] || [ -z "$FILE_PATH" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_system_hosts_file "$FILE_PATH"
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set (${RED}$FILE_PATH${RESET}) as"\
            "(${BLUE}$SCRIPT_NAME${RESET}) system hosts file."
    else
        ok_msg "Successfully set system hosts file (${GREEN}$FILE_PATH${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_cron_file() {
    echo; info_msg "Setting user cron job file -"
    info_msg "Type absolute file path or (${MAGENTA}.back${RESET})."
    local FILE_PATH=`fetch_file_path_from_user 'FilePath'`
    if [ $? -ne 0 ] || [ -z "$FILE_PATH" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_user_cron_file "$FILE_PATH"
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set (${RED}$FILE_PATH${RESET}) as"\
            "(${BLUE}$SCRIPT_NAME${RESET}) user cron job file."
    else
        ok_msg "Successfully set user cron job file (${GREEN}$FILE_PATH${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_wifi_essid() {
    echo; info_msg "Setting ${BLUE}$SCRIPT_NAME${RESET} WiFi ESSID -"
    info_msg "Type wireless gateway ESSID or (${MAGENTA}.back${RESET})."
    local WIFI_ESSID=`fetch_data_from_user 'WiFi(ESSID)'`
    if [ $? -ne 0 ] || [ -z "$WIFI_ESSID" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_wifi_essid "$WIFI_ESSID"
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set wireless gateway ESSID (${RED}$WIFI_ESSID${RESET})"
    else
        ok_msg "Successfully set wireless gateway ESSID (${GREEN}$WIFI_ESSID${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_wifi_password() {
    echo; info_msg "Setting ${BLUE}$SCRIPT_NAME${RESET} WiFi Password -"
    info_msg "Type wireless gateway password or (${MAGENTA}.back${RESET})."
    local WIFI_PSK=`fetch_password_from_user 'WiFi(PSK)'`
    if [ $? -ne 0 ] || [ -z "$WIFI_PSK" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_wifi_password $WIFI_PSK
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set wireless gateway password (${RED}$WIFI_PSK${RESET})"
    else
        ok_msg "Successfully set wireless gateway password (${GREEN}$WIFI_PSK${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_system_user() {
    echo; info_msg "Setting ${BLUE}$SCRIPT_NAME${RESET} head machine user name -"
    info_msg "Type system user name or (${MAGENTA}.back${RESET})."
    local SYS_USER=`fetch_data_from_user 'User'`
    if [ $? -ne 0 ] || [ -z "$SYS_USER" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_system_user $SYS_USER
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set system user name (${RED}$SYS_USER${RESET})"
    else
        ok_msg "Successfully set system user name (${GREEN}$SYS_USER${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_system_password() {
    echo; info_msg "Setting ${BLUE}$SCRIPT_NAME${RESET} head machine password -"
    info_msg "Type password or (${MAGENTA}.back${RESET})."
    local SYS_PASS=`fetch_password_from_user 'Password'`
    if [ $? -ne 0 ] || [ -z "$SYS_PASS" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_system_password $SYS_PASS
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set system password (${RED}$SYS_PASS${RESET})"
    else
        ok_msg "Successfully set system password (${GREEN}$SYS_PASS${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_system_permissions() {
    echo; info_msg "Setting user file permissions (NNN) -"
    info_msg "Type file permissions using octal notation or (${MAGENTA}.back${RESET})."
    local SYS_PERMS=`fetch_number_from_user 'Permsissions'`
    if [ $? -ne 0 ] || [ -z "$SYS_PERMS" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_user_file_permissions $SYS_PERMS
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set user file permissions (${RED}$SYS_PERMS${RESET})"
    else
        ok_msg "Successfully set user file permissions (${GREEN}$SYS_PERMS${RESET})."
    fi
    return $EXIT_CODE
}

function action_update_config_json_file() {
    local FILE_CONTENT="`format_config_json_file_content`"
    debug_msg "Formatted JSON config file content: ${FILE_CONTENT}"
    if [ $? -ne 0 ] || [ -z "$FILE_CONTENT" ]; then
        echo; nok_msg 'Something went wrong -'\
            'Could not format JSON config file content!'
        return 0
    fi
    clear_file "${NG_DEFAULT['conf-json-file']}"
    write_to_file "${NG_DEFAULT['conf-json-file']}" "$FILE_CONTENT"
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong -"\
            "Could not update JSON config file"\
            "(${RED}${NG_DEFAULT['conf-json-file']}${RESET})"
    else
        echo "$FILE_CONTENT
        "
        ok_msg "Successfully updated JSON config file"\
            "(${GREEN}${NG_DEFAULT['conf-json-file']}${RESET})."
    fi
    return $EXIT_CODE
}

function cli_action_setup() {
    local ARGUMENTS=( `format_setup_machine_cargo_arguments` )
    action_nomadsgold_cargo ${ARGUMENTS[@]}
    return $?
}

function cli_update_config_json_file() {
    local FILE_CONTENT="`format_config_json_file_content`"
    if [ $? -ne 0 ] || [ -z "$FILE_CONTENT" ]; then
        return 1
    fi
    echo "${FILE_CONTENT}" > ${MD_DEFAULT['conf-json-file']}
    return $?
}


