#!/bin/bash
#
# Regards, the Alveare Solutions #!/Society -x
#
# ACTIONS

function action_set_ar_report_id_length() {
    echo; info_msg "Setting Report ID Length -"
    info_msg "Type report ID length or (${MAGENTA}.back${RESET})."
    local LENGTH=`fetch_number_from_user 'Length'`
    if [ $? -ne 0 ] || [ -z "$LENGTH" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_ar_report_id_length $LENGTH
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set report ID length (${RED}$LENGTH${RESET}%)"
    else
        ok_msg "Successfully set report ID length (${GREEN}$LENGTH${RESET}%)."
    fi
    return $EXIT_CODE
}

function action_set_ar_report_id_characters() {
    echo; info_msg "Setting (A)Risk Report ID Characters -"
    info_msg "Type valid report ID characters or (${MAGENTA}.back${RESET})."
    local CHARACTERS=`fetch_data_from_user 'Characters'`
    if [ $? -ne 0 ] || [ -z "$CHARACTERS" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_ar_report_id_characters $CHARACTERS
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set report ID characters (${RED}$CHARACTERS${RESET})"
    else
        ok_msg "Successfully set report ID characters"\
            "(${GREEN}$CHARACTERS${RESET}%)"
    fi
    return $EXIT_CODE
}

function action_set_ar_report_location() {
    echo; info_msg "Setting (A)Risk Report Directory -"
    info_msg "Type directory path or (${MAGENTA}.back${RESET})."
    local DIR_PATH=`fetch_data_from_user 'DirPath'`
    if [ $? -ne 0 ] || [ -z "$DIR_PATH" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_ar_report_location $DIR_PATH
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set report directory (${RED}$DIR_PATH${RESET})"
    else
        ok_msg "Successfully set report directory (${GREEN}$DIR_PATH${RESET}%)"
    fi
    return $EXIT_CODE
}

function action_set_ar_conf_file() {
    echo; info_msg "Setting (A)Risk Config File -"
    info_msg "Type config file name or (${MAGENTA}.back${RESET})."
    local FILE_NAME=`fetch_data_from_user '(JSON)Config'`
    if [ $? -ne 0 ] || [ -z "$FILE_NAME" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_ar_conf_file $FILE_NAME
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set bot config file (${RED}$FILE_NAME${RESET})"
    else
        ok_msg "Successfully set bot config file (${GREEN}$FILE_NAME${RESET}%)"
    fi
    return $EXIT_CODE
}

function action_set_ar_profit_baby() {
    echo; info_msg "Setting Profit BABY!! Target -"
    info_msg "Type percent of account value at bot start-up"\
        "or (${MAGENTA}.back${RESET})."
    local PROFIT_BABY=`fetch_data_from_user 'ProfitBaby'`
    if [ $? -ne 0 ] || [ -z "$PROFIT_BABY" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_ar_profit_baby $PROFIT_BABY
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set profit BABY!! target (${RED}$PROFIT_BABY${RESET})"
    else
        ok_msg "Successfully set profit BABY!! target"\
            "(${GREEN}$PROFIT_BABY${RESET}%)"
    fi
    return $EXIT_CODE
}

function action_set_ar_watchdog_pid_file() {
    echo; info_msg "Setting (A)Risk Bot PID File -"
    info_msg "Type file path or (${MAGENTA}.back${RESET})."
    local FILE_PATH=`fetch_data_from_user 'FilePath'`
    if [ $? -ne 0 ] || [ -z "$FILE_PATH" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_ar_watchdog_pid_file $FILE_PATH
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set (A)Risk bot pid file (${RED}$FILE_PATH${RESET})"
    else
        ok_msg "Successfully set (A)Risk bot pid file"\
            "(${GREEN}$FILE_PATH${RESET})"
    fi
    return $EXIT_CODE
}

function action_set_ar_watchdog_anchor_file() {
    echo; info_msg "Setting (A)Risk Bot Anchor File -"
    info_msg "Type file path or (${MAGENTA}.back${RESET})."
    local FILE_PATH=`fetch_data_from_user 'FilePath'`

    if [ $? -ne 0 ] || [ -z "$FILE_PATH" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_ar_watchdog_anchor_file $FILE_PATH
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set (A)Risk bot anchor file (${RED}$FILE_PATH${RESET})"
    else
        ok_msg "Successfully set (A)Risk bot anchor file"\
            "(${GREEN}$FILE_PATH${RESET})"
    fi
    return $EXIT_CODE
}

function action_set_ar_api_key() {
    echo; info_msg "Setting Binance API Key -"
    info_msg "Type API key or (${MAGENTA}.back${RESET})."
    local KEY=`fetch_data_from_user '(API)Key'`
    if [ $? -ne 0 ] || [ -z "$URL" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_ar_api_key $KEY
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set binance API key (${RED}$KEY${RESET})"
    else
        ok_msg "Successfully set binance API key."
    fi
    return $EXIT_CODE
}

function action_set_ar_api_secret() {
    echo; info_msg "Setting Binance Secret Key -"
    info_msg "Type secret key or (${MAGENTA}.back${RESET})."
    local KEY=`fetch_data_from_user '(Secret)Key'`
    if [ $? -ne 0 ] || [ -z "$URL" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_ar_secret_key $KEY
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set binance secret key (${RED}$KEY${RESET})"
    else
        ok_msg "Successfully set binance secret key."
    fi
    return $EXIT_CODE
}

function action_set_ar_taapi_key() {
    echo; info_msg "Setting Taapi API Key -"
    info_msg "Type API key or (${MAGENTA}.back${RESET})."
    local KEY=`fetch_data_from_user '(API)Key'`
    if [ $? -ne 0 ] || [ -z "$URL" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_ar_taapi_key $KEY
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set taapi key (${RED}$KEY${RESET})"
    else
        ok_msg "Successfully set taapi key."
    fi
    return $EXIT_CODE
}

function action_set_ar_api_url() {
    echo; info_msg "Setting Binance API URL Target -"
    info_msg "Type URL or (${MAGENTA}.back${RESET})."
    local URL=`fetch_data_from_user 'URL'`
    if [ $? -ne 0 ] || [ -z "$URL" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_ar_api_url $URL
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set binance URL (${RED}$URL${RESET})"
    else
        ok_msg "Successfully set binance URL (${GREEN}$URL${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_ar_taapi_url() {
    echo; info_msg "Setting Taapi API URL Target -"
    info_msg "Type URL or (${MAGENTA}.back${RESET})."
    local URL=`fetch_data_from_user 'URL'`
    if [ $? -ne 0 ] || [ -z "$URL" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_ar_taapi_url $URL
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set taapi URL (${RED}$URL${RESET})"
    else
        ok_msg "Successfully set taapi URL (${GREEN}$URL${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_ar_risk_tolerance() {
    local VALID_SIDES=( `fetch_valid_ar_risk_tolerance_levels` )
    echo; info_msg "Setting Trading Bot Risk Tolerance -"
    info_msg "Type "\
        "or (${MAGENTA}.back${RESET})."
    while :; do
        info_msg "Select risk tolerance level or ${MAGENTA}Back${RESET}.
        "
        LEVEL=`fetch_selection_from_user '(Risk)Tolerance' ${VALID_SIDES[@]}`
        if [ $? -ne 0 ]; then
            echo; info_msg "Aborting action."
            return 0
        fi
        break
    done
    set_ar_risk_tolerance $LEVEL
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set trading bot risk tolerance (${RED}$LEVEL${RESET})"
    else
        ok_msg "Successfully set trading bot risk tolerance (${GREEN}$LEVEL${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_ar_side() {
    local VALID_SIDES=( `fetch_valid_ar_sides` )
    echo; info_msg "Setting Bot Trading Side -"
    info_msg "Type "\
        "or (${MAGENTA}.back${RESET})."
    while :; do
        info_msg "Select trading side or ${MAGENTA}Back${RESET}.
        "
        SIDE=`fetch_selection_from_user 'Side' ${VALID_SIDES[@]}`
        if [ $? -ne 0 ]; then
            echo; info_msg "Aborting action."
            return 0
        fi
        break
    done
    set_ar_side $SIDE
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set trading bot side (${RED}$SIDE${RESET})"
    else
        ok_msg "Successfully set trading bot side (${GREEN}$SIDE${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_ar_interval() {
    local VALID_INTERVALS=( `fetch_valid_ar_intervals` )
    echo; info_msg "Setting Chart Candle Interval -"
    info_msg "Type "\
        "or (${MAGENTA}.back${RESET})."
    while :; do
        info_msg "Select chart candle interval or ${MAGENTA}Back${RESET}.
        "
        INTERVAL=`fetch_selection_from_user 'Interval' ${VALID_INTERVALS[@]}`
        if [ $? -ne 0 ]; then
            echo; info_msg "Aborting action."
            return 0
        fi
        break
    done
    set_ar_interval $INTERVAL
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set candle interval (${RED}$INTERVAL${RESET})"
    else
        ok_msg "Successfully set candle interval (${GREEN}$INTERVAL${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_ar_market_open() {
    echo; info_msg "Setting Market Opening Time -"
    info_msg "Type time target market is opened using the HH:MM format"\
        "or (${MAGENTA}.back${RESET})."
    local MARKET_OPEN=`fetch_data_from_user 'OpeningHours'`
    if [ $? -ne 0 ] || [ -z "$MARKET_OPEN" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_ar_market_open $MARKET_OPEN
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set market opening time (${RED}$MARKET_OPEN${RESET})"
    else
        ok_msg "Successfully set market opening time (${GREEN}$MARKET_OPEN${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_ar_market_close() {
    echo; info_msg "Setting Market Closing Time -"
    info_msg "Type time target market is closed using the HH:MM format"\
        "or (${MAGENTA}.back${RESET})."
    local MARKET_CLOSE=`fetch_data_from_user 'ClosingHours'`
    if [ $? -ne 0 ] || [ -z "$MARKET_CLOSE" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_ar_market_close $MARKET_CLOSE
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set market closing time (${RED}$MARKET_CLOSE${RESET})"
    else
        ok_msg "Successfully set market closing time (${GREEN}$MARKET_CLOSE${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_ar_analyze_risk_off() {
    echo; fetch_ultimatum_from_user \
        "${YELLOW}Are you sure about this? Y/N${RESET}"
    if [ $? -ne 0 ]; then
        echo; info_msg "Aborting action."
        return 0
    fi
    set_ar_analyze_risk_flag 'off'
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set (${RED}(A)Risk${RESET}) risk analysis"\
            "to (${RED}OFF${RESET})."
    else
        ok_msg "Succesfully set (${BLUE}(A)Risk${RESET}) risk analysis"\
            "to (${RED}OFF${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_ar_analyze_risk_on() {
    echo; fetch_ultimatum_from_user \
        "${YELLOW}Are you sure about this? Y/N${RESET}"
    if [ $? -ne 0 ]; then
        echo; info_msg "Aborting action."
        return 0
    fi
    set_ar_analyze_risk_flag 'on'
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set (${RED}(A)Risk${RESET}) risk analysis"\
            "to (${RED}ON${RESET})."
    else
        ok_msg "Succesfully set (${BLUE}(A)Risk${RESET}) risk analysis"\
            "to (${GREEN}ON${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_ar_test_off() {
    echo; fetch_ultimatum_from_user \
        "${YELLOW}Are you sure about this? Y/N${RESET}"
    if [ $? -ne 0 ]; then
        echo; info_msg "Aborting action."
        return 0
    fi
    set_ar_test_flag 'off'
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set (${RED}(A)Risk${RESET}) test"\
            "to (${RED}OFF${RESET})."
    else
        ok_msg "Succesfully set (${BLUE}(A)Risk${RESET}) test"\
            "to (${RED}OFF${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_ar_test_on() {
    echo; fetch_ultimatum_from_user \
        "${YELLOW}Are you sure about this? Y/N${RESET}"
    if [ $? -ne 0 ]; then
        echo; info_msg "Aborting action."
        return 0
    fi
    set_ar_test_flag 'on'
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set (${RED}(A)Risk${RESET}) test"\
            "to (${RED}ON${RESET})."
    else
        ok_msg "Succesfully set (${BLUE}(A)Risk${RESET}) test"\
            "to (${GREEN}ON${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_ar_debug_off() {
    echo; fetch_ultimatum_from_user \
        "${YELLOW}Are you sure about this? Y/N${RESET}"
    if [ $? -ne 0 ]; then
        echo; info_msg "Aborting action."
        return 0
    fi
    set_ar_debug_flag 'off'
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set (${RED}(A)Risk${RESET}) debug"\
            "to (${RED}OFF${RESET})."
    else
        ok_msg "Succesfully set (${BLUE}(A)Risk${RESET}) silence"\
            "to (${RED}OFF${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_ar_debug_on() {
    echo; fetch_ultimatum_from_user \
        "${YELLOW}Are you sure about this? Y/N${RESET}"
    if [ $? -ne 0 ]; then
        echo; info_msg "Aborting action."
        return 0
    fi
    set_ar_debug_flag 'on'
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set (${RED}(A)Risk${RESET}) debug"\
            "to (${RED}ON${RESET})."
    else
        ok_msg "Succesfully set (${BLUE}(A)Risk${RESET}) silence"\
            "to (${GREEN}ON${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_ar_silence_off() {
    echo; fetch_ultimatum_from_user \
        "${YELLOW}Are you sure about this? Y/N${RESET}"
    if [ $? -ne 0 ]; then
        echo; info_msg "Aborting action."
        return 0
    fi
    set_ar_silence_flag 'off'
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set (${RED}(A)Risk${RESET}) silence"\
            "to (${RED}OFF${RESET})."
    else
        ok_msg "Succesfully set (${BLUE}(A)Risk${RESET}) silence"\
            "to (${RED}OFF${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_ar_silence_on() {
    echo; fetch_ultimatum_from_user \
        "${YELLOW}Are you sure about this? Y/N${RESET}"
    if [ $? -ne 0 ]; then
        echo; info_msg "Aborting action."
        return 0
    fi
    set_ar_silence_flag 'on'
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set (${RED}(A)Risk${RESET}) silence"\
            "to (${RED}ON${RESET})."
    else
        ok_msg "Succesfully set (${BLUE}(A)Risk${RESET}) silence"\
            "to (${GREEN}ON${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_ar_test_flag() {
    echo; case "${MD_DEFAULT['ar-test']}" in
        'on'|'On'|'ON')
            info_msg "Test is (${GREEN}ON${RESET}), switching to (${RED}OFF${RESET}) -"
            action_set_ar_test_off
            ;;
        'off'|'Off'|'OFF')
            info_msg "Test is (${RED}OFF${RESET}), switching to (${GREEN}ON${RESET}) -"
            action_set_ar_test_on
            ;;
        *)
            info_msg "Test flag not set, switching to (${GREEN}ON${RESET}) -"
            action_set_ar_test_off
            ;;
    esac
    return $?
}

function action_set_ar_debug_flag() {
    echo; case "${MD_DEFAULT['ar-debug']}" in
        'on'|'On'|'ON')
            info_msg "Debug is (${GREEN}ON${RESET}), switching to (${RED}OFF${RESET}) -"
            action_set_ar_debug_off
            ;;
        'off'|'Off'|'OFF')
            info_msg "Debug is (${RED}OFF${RESET}), switching to (${GREEN}ON${RESET}) -"
            action_set_ar_debug_on
            ;;
        *)
            info_msg "Debug flag not set, switching to (${GREEN}ON${RESET}) -"
            action_set_ar_debug_off
            ;;
    esac
    return $?
}

function action_set_ar_silence_flag() {
    echo; case "${MD_DEFAULT['ar-silence']}" in
        'on'|'On'|'ON')
            info_msg "Silence is (${GREEN}ON${RESET}), switching to (${RED}OFF${RESET}) -"
            action_set_ar_silence_off
            ;;
        'off'|'Off'|'OFF')
            info_msg "Silence is (${RED}OFF${RESET}), switching to (${GREEN}ON${RESET}) -"
            action_set_ar_silence_on
            ;;
        *)
            info_msg "Silence flag not set, switching to (${GREEN}ON${RESET}) -"
            action_set_ar_silence_off
            ;;
    esac
    return $?
}

function action_set_ar_analyze_risk_flag() {
    echo; case "${MD_DEFAULT['ar-analyze-risk']}" in
        'on'|'On'|'ON')
            info_msg "Risk Analysis is (${GREEN}ON${RESET}), switching to (${RED}OFF${RESET}) -"
            action_set_ar_analyze_risk_off
            ;;
        'off'|'Off'|'OFF')
            info_msg "Risk Analysis is (${RED}OFF${RESET}), switching to (${GREEN}ON${RESET}) -"
            action_set_ar_analyze_risk_on
            ;;
        *)
            info_msg "Risk Analysis flag not set, switching to (${GREEN}ON${RESET}) -"
            action_set_ar_analyze_risk_on
            ;;
    esac
    return $?
}

function action_set_ar_max_trades() {
    echo; info_msg "Setting Max. Trades/Day -"
    info_msg "Type number of trades the bot is allowed to take in a trading day"\
        "or (${MAGENTA}.back${RESET})."
    local MAX_TRADES=`fetch_number_from_user 'MaxTrades'`
    if [ $? -ne 0 ] || [ -z "$MAX_TRADES" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_ar_max_trades $MAX_TRADES
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set max trades (${RED}$MAX_TRADES${RESET}%)"
    else
        ok_msg "Successfully set max trades (${GREEN}$MAX_TRADES${RESET}%)."
    fi
    return $EXIT_CODE
}

function action_set_ar_order_amount() {
    echo; info_msg "Setting Trade Order Amount Value -"
    info_msg "Type percentage of account value to spend on each trade"\
        "or (${MAGENTA}.back${RESET})."
    local PERCENTAGE=`fetch_number_from_user 'Percent'`
    if [ $? -ne 0 ] || [ -z "$PERCENTAGE" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_ar_order_amount $PERCENTAGE
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set order amount (${RED}$PERCENTAGE${RESET}%)"
    else
        ok_msg "Successfully set order amount (${GREEN}$PERCENTAGE${RESET}%)."
    fi
    return $EXIT_CODE
}

function action_set_ar_stop_loss() {
    echo; info_msg "Setting Stop Loss Value -"
    info_msg "Type percentage of trade order value you want to cut your losses at"\
        "or (${MAGENTA}.back${RESET})."
    local PERCENTAGE=`fetch_number_from_user 'Percent'`
    if [ $? -ne 0 ] || [ -z "$PERCENTAGE" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_ar_stop_loss $PERCENTAGE
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set stop loss (${RED}$PERCENTAGE${RESET}%)"
    else
        ok_msg "Successfully set stop loss (${GREEN}$PERCENTAGE${RESET}%)."
    fi
    return $EXIT_CODE
}

function action_set_ar_take_profit() {
    echo; info_msg "Setting Take Profit Target Value -"
    info_msg "Type percentage of trade order value you want to cash-in at"\
        "or (${MAGENTA}.back${RESET})."
    local PERCENTAGE=`fetch_number_from_user 'Percent'`
    if [ $? -ne 0 ] || [ -z "$PERCENTAGE" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_ar_take_profit $PERCENTAGE
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set take profit target (${RED}$PERCENTAGE${RESET}%)"
    else
        ok_msg "Successfully set take profit target (${GREEN}$PERCENTAGE${RESET}%)."
    fi
    return $EXIT_CODE
}

function action_set_ar_indicator_update_delay() {
    echo; info_msg "Setting API Call Delay Time Value -"
    info_msg "Type number of seconds to wait between API calls"\
        "or (${MAGENTA}.back${RESET})."
    local SECONDS=`fetch_number_from_user 'Seconds'`
    if [ $? -ne 0 ] || [ -z "$SECONDS" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_ar_indicator_update_delay $SECONDS
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set API call delay (${RED}$SECONDS${RESET})"
    else
        ok_msg "Successfully set API call delay (${GREEN}$SECONDS${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_ar_period() {
    echo; info_msg "Setting Chart Period Value -"
    info_msg "Type number of candles to use when building trading chart"\
        "or (${MAGENTA}.back${RESET})."
    local CANDLES=`fetch_number_from_user 'Candles'`
    if [ $? -ne 0 ] || [ -z "$CANDLES" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_ar_period $CANDLES
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set period value (${RED}$CANDLES${RESET})"
    else
        ok_msg "Successfully set period value (${GREEN}$CANDLES${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_ar_backtrack() {
    echo; info_msg "Setting History Backtrack Value -"
    info_msg "Type number of candles to backtrack when comparing historical data"\
        "to curent values or (${MAGENTA}.back${RESET})."
    local CANDLES=`fetch_number_from_user 'Candles'`
    if [ $? -ne 0 ] || [ -z "$CANDLES" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_ar_backtrack $CANDLES
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set backtrack value (${RED}$CANDLES${RESET})"
    else
        ok_msg "Successfully set backtrack value (${GREEN}$CANDLES${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_ar_backtracks() {
    echo; info_msg "Setting History Backtracks Value -"
    info_msg "Type number of candles to backtrack when fetching chart history data"\
        "or (${MAGENTA}.back${RESET})."
    local CANDLES=`fetch_number_from_user 'Candles'`
    if [ $? -ne 0 ] || [ -z "$CANDLES" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_ar_backtracks $CANDLES
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set backtracks value (${RED}$CANDLES${RESET})"
    else
        ok_msg "Successfully set backtracks value (${GREEN}$CANDLES${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_ar_rsi_top() {
    echo; info_msg "Setting High RSI Value -"
    info_msg "Type a number between 1-100 to represent what High RSI means"\
        "or (${MAGENTA}.back${RESET})."
    local VALUE=`fetch_number_from_user '(RSI)High'`
    if [ $? -ne 0 ] || [ -z "$VALUE" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_ar_rsi_top $VALUE
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set High RSI value (${RED}$VALUE${RESET})"
    else
        ok_msg "Successfully set High RSI value (${GREEN}$VALUE${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_ar_rsi_bottom() {
    echo; info_msg "Setting Low RSI Value -"
    info_msg "Type a number between 1-100 to represent what Low RSI means"\
        "or (${MAGENTA}.back${RESET})."
    local VALUE=`fetch_number_from_user '(RSI)Low'`
    if [ $? -ne 0 ] || [ -z "$VALUE" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_ar_rsi_bottom $VALUE
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set Low RSI value (${RED}$VALUE${RESET})"
    else
        ok_msg "Successfully set Low RSI value (${GREEN}$VALUE${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_ar_macd_fast_period() {
    echo; info_msg "Setting MACD Fast Period -"
    info_msg "Type number of candles used in computing the Fast MACD line"\
        "or (${MAGENTA}.back${RESET})."
    local CANDLES=`fetch_number_from_user '(MACD)FastPeriod'`
    if [ $? -ne 0 ] || [ -z "$CANDLES" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_ar_macd_fast_period $CANDLES
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set MACD Fast Period (${RED}$CANDLES${RESET})"
    else
        ok_msg "Successfully set MACD Fast Period (${GREEN}$CANDLES${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_ar_macd_slow_period() {
    echo; info_msg "Setting MACD Slow Period -"
    info_msg "Type number of candles used in computing the Slow MACD line"\
        "or (${MAGENTA}.back${RESET})."
    local CANDLES=`fetch_number_from_user '(MACD)SlowPeriod'`
    if [ $? -ne 0 ] || [ -z "$CANDLES" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_ar_macd_slow_period $CANDLES
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set MACD Slow Period (${RED}$CANDLES${RESET})"
    else
        ok_msg "Successfully set MACD Slow Period (${GREEN}$CANDLES${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_ar_strategy() {
    echo; info_msg "Setting Trading Strategy -"
    info_msg "Type trading strategy label separated by commas"\
        "or (${MAGENTA}.back${RESET})."
    local STRATEGY_CSV=`fetch_data_from_user 'Strategy'`
    if [ $? -ne 0 ] || [ -z "$STRATEGY_CSV" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_ar_strategy $STRATEGY_CSV
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set trading strategy (${RED}$STRATEGY_CSV${RESET})"
    else
        ok_msg "Successfully set trading strategy (${GREEN}$STRATEGY_CSV${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_ar_macd_signal_period() {
    echo; info_msg "Setting MACD Signal Period -"
    info_msg "Type number of candles used in computing the MACD Signal line"\
            "or (${MAGENTA}.back${RESET})."
    local CANDLES=`fetch_number_from_user '(MACD)SignalPeriod'`
    if [ $? -ne 0 ] || [ -z "$CANDLES" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_ar_macd_signal_period_movement $CANDLES
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set MACD signal period (${RED}$CANDLES${RESET})"
    else
        ok_msg "Successfully set MACD signal period (${GREEN}$CANDLES${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_ar_price_movement() {
    echo; info_msg "Setting Price Movement -"
    info_msg "Type percentage price has to move over specified period in order"\
        "to trigger a large movement alarm - or (${MAGENTA}.back${RESET})."
    local PERCENTAGE=`fetch_number_from_user 'Percentage'`
    if [ $? -ne 0 ] || [ -z "$PERCENTAGE" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_ar_price_movement $PERCENTAGE
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set price movement (${RED}$PERCENTAGE${RESET})"
    else
        ok_msg "Successfully set price movement (${GREEN}$PERCENTAGE${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_ar_volume_movement() {
    echo; info_msg "Setting Volume Movement -"
    info_msg "Type percentage volume has to move over specified period in order"\
        "to trigger a large movement alarm - or (${MAGENTA}.back${RESET})."
    local PERCENTAGE=`fetch_number_from_user 'Percentage'`
    if [ $? -ne 0 ] || [ -z "$PERCENTAGE" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_ar_volume_movement $PERCENTAGE
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set volume movement (${RED}$PERCENTAGE${RESET})"
    else
        ok_msg "Successfully set volume movement (${GREEN}$PERCENTAGE${RESET})."
    fi
    return $EXIT_CODE
}

function action_ar_start_bot_in_foreground() {
    local ARGUMENTS=( `format_arisk_start_trading_bot_cargo_args` )
    local ACTION_VALUES=( `fetch_arisk_start_trading_bot_action_value_labels` )
    confirm_loaded_action_values_with_user ${ACTION_VALUES[@]}
    debug_msg "Executing: (./`basename ${NG_CARGO['asymetric-risk']}` ${ARGUMENTS[@]})"
    action_asymetric_risk_cargo ${ARGUMENTS[@]}
    return $?
}

function action_ar_start_bot_in_background() {
    local ARGUMENTS=( `format_arisk_start_trading_bot_cargo_args` )
    local ACTION_VALUES=( `fetch_arisk_start_trading_bot_action_value_labels` )
    confirm_loaded_action_values_with_user ${ACTION_VALUES[@]}
    debug_msg "Executing: (./`basename ${NG_CARGO['asymetric-risk']}` ${ARGUMENTS[@]})"
    action_asymetric_risk_cargo ${ARGUMENTS[@]} &> /dev/null &
    # Fetch proces PID and create anchor
    echo "$!" | tee ${MD_DEFAULT['ar-watchdog-pid-file']} \
        ${MD_DEFAULT['ar-watchdog-anchor-file']} &> /dev/null
    return $?
}

function action_ar_stop_bot() {
    local ARGUMENTS=( `format_arisk_stop_trading_bot_cargo_args` )
    local ACTION_VALUES=( `fetch_arisk_stop_trading_bot_action_value_labels` )
    confirm_loaded_action_values_with_user ${ACTION_VALUES[@]}
    debug_msg "Executing: (./`basename ${NG_CARGO['asymetric-risk']}` ${ARGUMENTS[@]})"
    action_asymetric_risk_cargo ${ARGUMENTS[@]}
    return $?
}

function action_ar_report_list() {
    local ARGUMENTS=( `format_arisk_report_list_cargo_args` )
    local ACTION_VALUES=( `fetch_arisk_report_list_action_value_labels` )
    confirm_loaded_action_values_with_user ${ACTION_VALUES[@]}
    debug_msg "Executing: (./`basename ${NG_CARGO['asymetric-risk']}` ${ARGUMENTS[@]})"
    action_asymetric_risk_cargo ${ARGUMENTS[@]}
    return $?
}

function action_ar_report_all() {
    local ARGUMENTS=( `format_arisk_report_cargo_args` )
    local ACTION_VALUES=( `fetch_arisk_report_action_value_labels` )
    confirm_loaded_action_values_with_user ${ACTION_VALUES[@]}
    debug_msg "Executing: (./`basename ${NG_CARGO['asymetric-risk']}` ${ARGUMENTS[@]})"
    action_asymetric_risk_cargo ${ARGUMENTS[@]}
    return $?
}

function action_ar_report_trading_history() {
    local ARGUMENTS=( `format_arisk_report_trade_history_cargo_args` )
    local ACTION_VALUES=( `fetch_arisk_report_trade_history_action_value_labels` )
    confirm_loaded_action_values_with_user ${ACTION_VALUES[@]}
    debug_msg "Executing: (./`basename ${NG_CARGO['asymetric-risk']}` ${ARGUMENTS[@]})"
    action_asymetric_risk_cargo ${ARGUMENTS[@]}
    return $?
}

function action_ar_report_deposit_history() {
    local ARGUMENTS=( `format_arisk_report_deposit_history_cargo_args` )
    local ACTION_VALUES=( `fetch_arisk_report_deposit_history_action_value_labels` )
    confirm_loaded_action_values_with_user ${ACTION_VALUES[@]}
    debug_msg "Executing: (./`basename ${NG_CARGO['asymetric-risk']}` ${ARGUMENTS[@]})"
    action_asymetric_risk_cargo ${ARGUMENTS[@]}
    return $?
}

function action_ar_report_withdrawal_history() {
    local ARGUMENTS=( `format_arisk_report_withdrawal_history_cargo_args` )
    local ACTION_VALUES=( `fetch_arisk_report_withdrawal_history_action_value_labels` )
    confirm_loaded_action_values_with_user ${ACTION_VALUES[@]}
    debug_msg "Executing: (./`basename ${NG_CARGO['asymetric-risk']}` ${ARGUMENTS[@]})"
    action_asymetric_risk_cargo ${ARGUMENTS[@]}
    return $?
}

function action_ar_report_success_rate() {
    local ARGUMENTS=( `format_arisk_report_success_rate_cargo_args` )
    local ACTION_VALUES=( `fetch_arisk_report_success_rate_action_value_labels` )
    confirm_loaded_action_values_with_user ${ACTION_VALUES[@]}
    debug_msg "Executing: (./`basename ${NG_CARGO['asymetric-risk']}` ${ARGUMENTS[@]})"
    action_asymetric_risk_cargo ${ARGUMENTS[@]}
    return $?
}

function action_ar_view_report() {
    local ARGUMENTS=( `format_arisk_view_report_cargo_args` )
    local ACTION_VALUES=( `fetch_arisk_view_report_action_value_labels` )
    confirm_loaded_action_values_with_user ${ACTION_VALUES[@]}
    debug_msg "Executing: (./`basename ${NG_CARGO['asymetric-risk']}` ${ARGUMENTS[@]})"
    action_asymetric_risk_cargo ${ARGUMENTS[@]}
    return $?
}

function action_ar_view_market_details() {
    local ARGUMENTS=( `format_arisk_view_market_details_cargo_args` )
    local ACTION_VALUES=( `fetch_arisk_view_market_details_action_value_labels` )
    confirm_loaded_action_values_with_user ${ACTION_VALUES[@]}
    debug_msg "Executing: (./`basename ${NG_CARGO['asymetric-risk']}` ${ARGUMENTS[@]})"
    action_asymetric_risk_cargo ${ARGUMENTS[@]}
    return $?
}

function action_ar_view_account_details() {
    local ARGUMENTS=( `format_arisk_view_account_details_cargo_args` )
    local ACTION_VALUES=( `fetch_arisk_view_account_details_action_value_labels` )
    confirm_loaded_action_values_with_user ${ACTION_VALUES[@]}
    debug_msg "Executing: (./`basename ${NG_CARGO['asymetric-risk']}` ${ARGUMENTS[@]})"
    action_asymetric_risk_cargo ${ARGUMENTS[@]}
    return $?
}

function action_ar_remove_reports() {
    echo; info_msg "Removing ${BLUE}(A)${RED}Risk${RESET} reports -"
    info_msg "Type report ID's separated by commas or (${MAGENTA}.back${RESET})."
    local REPORT_CSV=`fetch_data_from_user 'Reports'`
    if [ $? -ne 0 ] || [ -z "$REPORT_CSV" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    rm `echo ${REPORT_CSV} | tr ',' ' '` &> /dev/null
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not remove reports! (${RED}$EXIT_CODE${RESET})"
    else
        ok_msg "Successfully removed reports! (${GREEN}$EXIT_CODE${RESET})"
    fi
    return $EXIT_CODE
}

function action_update_asymetric_risk_bot_config_json() {
    local FILE_CONTENT="`format_ar_config_json_file_content`"
    local FILE_PATH="${MD_DEFAULT['conf-dir']}/${MD_DEFAULT['ar-conf-json-file']}"
    echo; info_msg "Updating ${BLUE}(A)${RED}Risk${RESET} config file -"
    debug_msg "Formatted (A)Risk JSON config file content: ${FILE_CONTENT}"
    if [ $? -ne 0 ] || [ -z "$FILE_CONTENT" ]; then
        echo; nok_msg 'Something went wrong -'\
            'Could not format (A)Risk JSON config file content!'
        return 0
    fi
    clear_file "${FILE_PATH}"
    write_to_file "${FILE_PATH}" "$FILE_CONTENT"
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong -"\
            "Could not update (A)Risk JSON config file"\
            "(${RED}${FILE_PATH}${RESET})"
    else
        echo "$FILE_CONTENT
        "
        ok_msg "Successfully updated (A)Risk JSON config file"\
            "(${GREEN}${FILE_PATH}${RESET})."
    fi
    return $EXIT_CODE
}

function action_update_bot_config_json_files() {
    local FAILURES=0
    echo; info_msg "Updating all trading bot config files -"
    action_update_asymetric_risk_bot_config_json
    local FAILURES=$((FAILURES+$?))
    return $FAILURES
}

function action_ar_check_bot_running() {
    local EXIT_CODE=0; echo
    if [ ! -f ${MD_DEFAULT['ar-watchdog-pid-file']} ]; then
        info_msg "(A)Risk trading bot not currently running."
        return $EXIT_CODE
    fi
    local AR_PID=`cat ${MD_DEFAULT['ar-watchdog-pid-file']}`
    if [ $AR_PID -ne $AR_PID ]; then
        warning_msg "Malformed PID file content! (${AR_PID})"
        return 1
    fi
    ps $AR_PID &> /dev/null
    local EXIT_CODE=$?
    if [ $EXIT_CODE -eq 0 ]; then
        ok_msg "(A)Risk trading bot running! PID (${AR_PID})"
    else
        nok_msg "PID (${AR_PID}) not found! (A)Risk trading bot not running!"
        info_msg "Cleaning up pid file..."
        rm ${MD_DEFAULT['ar-watchdog-pid-file']} &> /dev/null
        local EXIT_CODE=2
    fi
    return $EXIT_CODE
}

function action_ar_view_bot_config() {
    echo; info_msg "Viewing ${BLUE}(A)${RED}Risk${RESET} bot config file -"
    cat -n "${MD_DEFAULT['conf-dir']}/${MD_DEFAULT['ar-conf-file']}"
    return $?
}

function action_ar_edit_bot_config() {
    echo; info_msg "Editing ${BLUE}(A)${RED}Risk${RESET} bot config file -"
    vim "${MD_DEFAULT['conf-dir']}/${MD_DEFAULT['ar-conf-file']}"
    return $?
}

function action_cargo() {
    local CARGO_SCRIPT="$1"
    local ARGUMENTS=( ${@:2} )
    trap 'trap - SIGINT; echo ''[ SIGINT ]: Aborting action.''; return 0' SIGINT
    echo; ${NG_CARGO[${CARGO_SCRIPT}]} ${ARGUMENTS[@]} 2> /dev/null; trap - SIGINT
    return $?
}

function action_asymetric_risk_cargo() {
    local ARGUMENTS=( $@ )
    action_cargo 'asymetric-risk' ${ARGUMENTS[@]}
    local EXIT_CODE=$?
    if [ $EXIT_CODE -ne 0 ]; then
        echo "[ EXIT ]: $EXIT_CODE"
    fi
    return 0
}

function action_nomadsgold_cargo() {
    local ARGUMENTS=( $@ )
    action_cargo 'nomads-gold' ${ARGUMENTS[@]}
    local EXIT_CODE=$?
    if [ $EXIT_CODE -ne 0 ]; then
        echo "[ EXIT ]: $EXIT_CODE"
    fi
    return 0
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
    echo; warning_msg "This action should not be taken manually! "\
        "But we consider you to be a big boy/girl now, so go ahead ^^"
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
    echo; warning_msg "This action should not be taken manually! "\
        "But we consider you to be a big boy/girl now, so go ahead ^^"
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
    echo; info_msg "Setting ${BLUE}$SCRIPT_NAME${RESET} ticker symbol -"
    info_msg "Type symbol or (${MAGENTA}.back${RESET})."
    local STOCK=`fetch_data_from_user 'Symbol'`
    if [ $? -ne 0 ] || [ -z "$STOCK" ]; then
        echo; info_msg 'Aborting action.'
        return 0
    fi
    set_stock_symbol "$STOCK"
    local EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set ticker symbol (${RED}$STOCK${RESET})"
    else
        ok_msg "Successfully set ticker symbol (${GREEN}$STOCK${RESET})"
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
    echo; case "${MD_DEFAULT['silence']}" in
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
    echo; case "${MD_DEFAULT['silence']}" in
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
    echo; case "${MD_DEFAULT['silence']}" in
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
    echo; info_msg "Setting ${BLUE}$SCRIPT_NAME${RESET} machine user name -"
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
    echo; info_msg "Setting ${BLUE}$SCRIPT_NAME${RESET} machine password -"
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

function action_set_ar_stop_limit() {
    echo; warning_msg "Value fixed to (${MD_DEFAULT['ar-stop-limit']})"\
        "and cannot be changed in this version.
        "
    return 0
}

function action_set_ar_stop_price() {
    echo; warning_msg "Value fixed to (${MD_DEFAULT['ar-stop-price']})"\
        "and cannot be changed in this version.
        "
    return 0
}

function action_set_ar_stop_limit_price() {
    echo; warning_msg "Value fixed to (${MD_DEFAULT['ar-stop-limit-price']})"\
        "and cannot be changed in this version.
        "
    return 0
}

function action_set_ar_stop_limit_time_in_force() {
    echo; warning_msg "Value fixed to (${MD_DEFAULT['ar-stop-limit-time-in-force']})"\
        "and cannot be changed in this version.
        "
    return 0
}

function action_set_ar_trading_account_type() {
    echo; warning_msg "Value fixed to (${MD_DEFAULT['ar-trading-account-type']})"\
        "and cannot be changed at runtime in this version.
        "
    return 0
}

function action_set_ar_trading_order_type() {
    echo; warning_msg "Value fixed to (${MD_DEFAULT['ar-trading-order-type']})"\
        "and cannot be changed at runtime in this version.
        "
    return 0
}

function action_set_ar_order_time_in_force() {
    echo; warning_msg "Value fixed to (${MD_DEFAULT['ar-order-time-in-force']})"\
        "and cannot be changed at runtime in this version.
        "
    return 0
}

function action_set_ar_order_response_type() {
    echo; warning_msg "Value fixed to (${MD_DEFAULT['ar-order-response-type']})"\
        "and cannot be changed at runtime in this version.
        "
    return 0
}

function action_set_ar_order_recv_window() {
    echo; warning_msg "Value fixed to (${MD_DEFAULT['ar-order-recv-window']})"\
        "and cannot be changed at runtime in this version.
        "
    return 0
}

function action_set_ar_order_price() {
    echo; warning_msg "Value fixed to (${MD_DEFAULT['ar-order-price']})"\
        "and cannot be changed at runtime in this version.
        "
    return 0
}

function action_set_ar_trailing_stop() {
    echo; warning_msg "Value fixed to (${MD_DEFAULT['ar-trailing-stop']})"\
        "and cannot be changed at runtime in this version.
        "
    return 0
}

# CODE DUMP


