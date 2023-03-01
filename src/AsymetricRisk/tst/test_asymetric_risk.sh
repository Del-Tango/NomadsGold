#!/bin/bash
#
# Regards, the Alveare Solutions #!/Society -x
#
# AsymetricRisk - (A)Risk - Functional auto-tester

declare -A AR_DEFAULT
declare -A AR_AUTO_TESTERS
declare -A AR_AUTO_TESTER_SETUP
declare -A AR_AUTO_TESTER_TEARDOWN

FULL_TEST_FLAG="$1"
AR_INIT='./asymetric_risk.py'
AR_DEFAULT=(
['log-file']="./log/asymetric_risk.log"
['conf-file']="./conf/asymetric_risk.conf.json"
['profit-baby']=20
['watchdog-pid-file']=".ar-bot.pid"
['watchdog-anchor-file']=".ar-bot.anchor"
['timestamp-format']="%d/%m/%Y-%H:%M:%S"
['api-key']="<SoMuchNopeGetYourOwn>"
['api-secret']="<SoMuchNopeGetYourOwn>"
['taapi-key']="<SoMuchNopeGetYourOwn>"
['api-url']="https://api.binance.com/api"
['taapi-url']="https://api.taapi.io"
['max-trades']=3
['trading-account-type']="SPOT"
['trading-order-type']="LIMIT"
['base-currency']="BTC"
['quote-currency']="USDT"
['ticker-symbol']="BTC/USDT"
['order-time-in-force']="GTC"
['order-response-type']="JSON"
['order-recv-window']=60000
['order-list-id']="-"
['order-limit-id']="-"
['order-stop-id']="-"
['order-iceberg-quantity']=0
['order-price']=0
['order-amount']=1
['stop-loss']=10
['take-profit']=30
['trailing-stop']=10
['test']='off'
['debug']='off'
['silence']='off'
['indicator-update-delay']=18
['risk-tolerance']='High'
['analyze-risk']='on'
['strategy']="vwap,rsi,macd,adx,ma,ema,price,volume"
['side']="auto"
['interval']="5m"
['period-start']="-"
['period-end']="-"
['period']=14
['market-open']="08:00"
['market-close']="22:00"
['backtrack']=5
['backtracks']=14
['stop-limit']=0
['stop-price']=0
['stop-limit-price']=0
['stop-iceberg-quantity']=0
['stop-limit-time-in-force']="GTC"
['price-movement']=5
['rsi-top']=70
['rsi-bottom']=30
['rsi-period']=14
['rsi-backtrack']=5
['rsi-backtracks']=12
['rsi-chart']="candles"
['rsi-interval']="5m"
['volume-movement']=5
['volume-interval']="5m"
['ma-period']=30
['ma-backtrack']=5
['ma-backtracks']=12
['ma-chart']="candles"
['ma-interval']="5m"
['ema-period']=30
['ema-backtrack']=5
['ema-backtracks']=12
['ema-chart']="candles"
['ema-interval']="5m"
['macd-backtrack']= 5
['macd-backtracks']=12
['macd-chart']="candles"
['macd-fast-period']=12
['macd-slow-period']=26
['macd-signal-period']=9
['macd-interval']="5m"
['adx-period']=14
['adx-backtrack']=5
['adx-backtracks']=12
['adx-chart']="candles"
['adx-interval']="5m"
['vwap-period']=14
['vwap-backtrack']=5
['vwap-backtracks']=12
['vwap-chart']="candles"
['vwap-interval']="5m"
['price-period']=14
['price-backtrack']=5
['price-backtracks']=12
['price-chart']="candles"
['price-interval']="5m"
['report-id']="-"
['report-id-length']=8
['report-id-characters']="abcdefghijklmnopqrstuvwxyz0123456789"
['report-location']="./data/reports"
)

AR_AUTO_TESTERS=(
['test-start-watchdog']='format_asymetric_risk_action_start_watchdog_args'
['test-stop-watchdog']='format_asymetric_risk_action_stop_watchdog_args'
['test-generate-report']='format_asymetric_risk_action_generate_report_args'
['test-trade-report']='format_asymetric_risk_action_generate_trade_history_report_args'
['test-deposit-report']='format_asymetric_risk_action_generate_deposit_history_report_args'
['test-withdrawal-report']='format_asymetric_risk_action_generate_withdrawal_history_report_args'
['test-list-reports']='format_asymetric_risk_action_list_reports_args'
['test-read-reports']='format_asymetric_risk_action_read_reports_args'
['test-remove-reports']='format_asymetric_risk_action_remove_reports_args'
['test-help']='format_asymetric_risk_action_help_args'
)

AR_AUTO_TESTER_SETUP=(
['test-start-watchdog']='setup_asymetric_risk_action_test_start_watchdog'
['test-stop-watchdog']='setup_asymetric_risk_action_test_stop_watchdog'
['test-generate-report']='setup_asymetric_risk_action_test_generate_report'
['test-trade-report']='setup_asymetric_risk_action_test_trade_report'
['test-deposit-report']='setup_asymetric_risk_action_test_deposit_report'
['test-withdrawal-report']='setup_asymetric_risk_action_test_withdrawal_report'
['test-list-reports']='setup_asymetric_risk_action_test_list_reports'
['test-read-reports']='setup_asymetric_risk_action_test_read_reports'
['test-remove-reports']='setup_asymetric_risk_action_test_remove_reports'
['test-help']='setup_asymetric_risk_action_test_help'
)

AR_AUTO_TESTER_TEARDOWN=(
['test-start-watchdog']='teardown_asymetric_risk_action_test_start_watchdog'
['test-stop-watchdog']='teardown_asymetric_risk_action_test_stop_watchdog'
['test-generate-report']='teardown_asymetric_risk_action_test_generate_report'
['test-trade-report']='teardown_asymetric_risk_action_test_trade_report'
['test-deposit-report']='teardown_asymetric_risk_action_test_deposit_report'
['test-withdrawal-report']='teardown_asymetric_risk_action_test_withdrawal_report'
['test-list-reports']='teardown_asymetric_risk_action_test_list_reports'
['test-read-reports']='teardown_asymetric_risk_action_test_read_reports'
['test-remove-reports']='teardown_asymetric_risk_action_test_remove_reports'
['test-help']='teardown_asymetric_risk_action_test_help'
)

# GENERAL

function run_init_script() {
    local ARGUMENTS=( $@ )
    log_msg 'DEBUG' "Executing: ${AR_INIT} ${ARGUMENTS[@]}"
    $AR_INIT ${ARGUMENTS[@]}
    return $?
}

function log_msg() {
    local LVL="${1:-INFO}"
    local MSG="${@:2}"
    local TIMESTAMP=`date "+${AR_DEFAULT['timestamp-format']}"`
    echo "[ ${TIMESTAMP} ] (A)RAT [ ${LVL} ]: ${MSG}" \
        >> ${AR_DEFAULT['log-file']}
    return $?
}

function stdout_msg() {
    local LVL="${1:-INFO}"
    local MSG="${@:2}"
    echo "[ ${LVL} ]: ${MSG}"
    log_msg "$LVL" "$MSG"
    return $?
}

# FORMATTERS

function format_asymetric_risk_action_start_watchdog_args() {
    local ARGUMENTS=( `format_asymetric_risk_constant_args`
        "--action start-watchdog"
        "--strategy ${AR_DEFAULT['strategy']}"
        "--base-currency ${AR_DEFAULT['base-currency']}"
        "--quote-currency ${AR_DEFAULT['quote-currency']}"
        "--market-open ${AR_DEFAULT['market-open']}"
        "--market-close ${AR_DEFAULT['market-close']}"
        "--max-trades ${AR_DEFAULT['max-trades']}"
        "--profit-baby ${AR_DEFAULT['profit-baby']}"
        "--stop-loss ${AR_DEFAULT['stop-loss']}"
        "--take-profit ${AR_DEFAULT['take-profit']}"
        "--side ${AR_DEFAULT['side']}"
        "--interval ${AR_DEFAULT['interval']}"
        "--period ${AR_DEFAULT['period']}"
        "--risk-tolerance ${AR_DEFAULT['risk-tolerance']}"
        "--analyze-risk"
        "&"
    )
    echo ${ARGUMENTS[@]}
    return $?
}

function format_asymetric_risk_action_list_reports_args() {
    local ARGUMENTS=( `format_asymetric_risk_constant_args`
        "--action list-reports"
    )
    echo ${ARGUMENTS[@]}
    return $?
}

function format_asymetric_risk_action_read_reports_args() {
    local ARGUMENTS=( `format_asymetric_risk_constant_args`
        "--action view-report"
        "--report-id ${AR_DEFAULT['report-id']}"
    )
    echo ${ARGUMENTS[@]}
    return $?
}

function format_asymetric_risk_action_stop_watchdog_args() {
    local ARGUMENTS=( `format_asymetric_risk_constant_args`
        "--action stop-watchdog"
    )
    echo ${ARGUMENTS[@]}
    return $?
}

function format_asymetric_risk_action_generate_deposit_history_report_args() {
    local ARGUMENTS=( `format_asymetric_risk_constant_args`
        "--action deposit-report"
    )
    echo ${ARGUMENTS[@]}
    return $?
}

function format_asymetric_risk_action_generate_withdrawal_history_report_args() {
    local ARGUMENTS=( `format_asymetric_risk_constant_args`
        "--action withdrawal-report"
    )
    echo ${ARGUMENTS[@]}
    return $?
}

function format_asymetric_risk_action_generate_trade_history_report_args() {
    local ARGUMENTS=( `format_asymetric_risk_constant_args`
        "--action trade-report"
    )
    echo ${ARGUMENTS[@]}
    return $?
}

function format_asymetric_risk_action_generate_report_args() {
    local ARGUMENTS=( `format_asymetric_risk_constant_args`
        "--action report"
    )
    echo ${ARGUMENTS[@]}
    return $?
}

function format_asymetric_risk_action_remove_reports_args() {
    local ARGUMENTS=( `format_asymetric_risk_constant_args`
        "--action remove-report"
        "--report-id ${AR_DEFAULT['report-id']}"
    )
    echo ${ARGUMENTS[@]}
    return $?
}

function format_asymetric_risk_action_get_config_args() {
    local ARGUMENTS=( `format_asymetric_risk_constant_args`
        "--action get-config"
    )
    echo ${ARGUMENTS[@]}
    return $?
}

function format_asymetric_risk_action_help_args() {
    local ARGUMENTS=( "--help" )
    echo ${ARGUMENTS[@]}
    return $?
}

function format_asymetric_risk_constant_args() {
    local ARGUMENTS=(
        "--log-file ${AR_DEFAULT['log-file']}"
        "--config-file ${AR_DEFAULT['conf-file']}"
    )
    if [[ ${AR_DEFAULT['silence']} == 'on' ]]; then
        local ARGUMENTS=( ${ARGUMENTS[@]} '--silence' )
    fi
    if [[ ${AR_DEFAULT['debug']} == 'on' ]]; then
        local ARGUMENTS=( ${ARGUMENTS[@]} '--debug' )
    fi
    if [[ ${AR_DEFAULT['test']} == 'on' ]]; then
        local ARGUMENTS=( ${ARGUMENTS[@]} '--test' )
    fi
    echo -n "${ARGUMENTS[@]}"
    return $?
}

# SETUP

function setup_asymetric_risk_action_test_stop_watchdog() {
    # Start watchdog in background and create watchdog anchor file
    local ARGUMENTS=( `${AR_AUTO_TESTERS['test-start-watchdog']}` )
    run_init_script ${ARGUMENTS[@]} &
    return $?
}

function setup_asymetric_risk_action_test_list_reports() {
    # Generate all reports
    local ARGUMENTS=( `${AR_AUTO_TESTERS['test-generate-report']}` )
    run_init_script ${ARGUMENTS[@]}
    return $?
}

function setup_asymetric_risk_action_test_remove_reports() {
    # Ensure at least two reports exist, fetch id's
    setup_asymetric_risk_action_test_read_reports
    return $?
}

function setup_asymetric_risk_action_test_read_reports() {
    local EXIT_CODE=0
    # Ensure at least two reports exist, fetch id's
    if [[ -z "`ls -1 ${AR_DEFAULT['report-location']} 2> /dev/null`" ]] \
            || [[ `ls -1 ${AR_DEFAULT['report-location']} | wc -w 2> /dev/null` -lt 2 ]]; then
        local ARGUMENTS=( `${AR_AUTO_TESTERS['test-generate-report']}` )
        run_init_script ${ARGUMENTS[@]}
        local EXIT_CODE=$?
    fi
    local REPORT_IDS=(
        `ls -1 ${AR_DEFAULT['report-location']} | cut -d '.' -f 1 2> /dev/null`
    )
    AR_DEFAULT['report-id']="`echo ${REPORT_IDS[@]} | tr ' ' ','`"
    return $EXIT_CODE
}

function setup_asymetric_risk_action_test_start_watchdog() {
    # Nothing yet
    return 0
}

function setup_asymetric_risk_action_test_generate_report() {
    # Nothing yet
    return 0
}

function setup_asymetric_risk_action_test_trade_report() {
    # Ensure a trade occured? maybe? I don't know if that's a good ideea.
    return 0
}

function setup_asymetric_risk_action_test_deposit_report() {
    # Just run it already.
    return 0
}

function setup_asymetric_risk_action_test_withdrawal_report() {
    # Read that again.
    return 0
}

function setup_asymetric_risk_action_test_help() {
    # Nothing yet, probably never honestly.
    return 0
}

# TEARDOWN

function teardown_asymetric_risk_action_test_start_watchdog() {
    # Kill watchdog/remove process anchor file
    local ARGUMENTS=( `${AR_AUTO_TESTERS['test-stop-watchdog']}` )
    run_init_script ${ARGUMENTS[@]}
    if [ -f "${AR_DEFAULT['watchdog-anchor-file']}" ]; then
        rm ${AR_DEFAULT['watchdog-anchor-file']} &> /dev/null
    fi
    return $?
}

function teardown_asymetric_risk_action_test_stop_watchdog() {
    local EXIT_CODE=0
    # Ensure anchor and pid files cleaned
    if [ -f "${AR_DEFAULT['watchdog-anchor-file']}" ]; then
        rm ${AR_DEFAULT['watchdog-anchor-file']} &> /dev/null
        local EXIT_CODE=$((EXIT_CODE+$?))
    fi
    if [ -f "${AR_DEFAULT['watchdog-pid-file']}" ]; then
        rm ${AR_DEFAULT['watchdog-pid-file']} &> /dev/null
        local EXIT_CODE=$((EXIT_CODE+$?))
    fi
    return $EXIT_CODE
}

function teardown_asymetric_risk_action_test_generate_report() {
    # Remove all reports
    rm "${AR_DEFAULT['report-location']}/*" &> /dev/null
    return $?
}

function teardown_asymetric_risk_action_test_trade_report() {
    # Remove reports
    rm "${AR_DEFAULT['report-location']}/*.ths" &> /dev/null
    return $?
}

function teardown_asymetric_risk_action_test_deposit_report() {
    # Remove reports
    rm "${AR_DEFAULT['report-location']}/*.dep" &> /dev/null
    return $?
}

function teardown_asymetric_risk_action_test_withdrawal_report() {
    # Remove reports
    rm "${AR_DEFAULT['report-location']}/*.wdr" &> /dev/null
    return $?
}

function teardown_asymetric_risk_action_test_list_reports() {
    # Remove all reports
    rm "${AR_DEFAULT['report-location']}/*" &> /dev/null
    return $?
}

function teardown_asymetric_risk_action_test_read_reports() {
    # Remove all reports
    rm "${AR_DEFAULT['report-location']}/*" &> /dev/null
    return $?
}

function teardown_asymetric_risk_action_test_remove_reports() {
    # Remove all reports
    rm "${AR_DEFAULT['report-location']}/*" &> /dev/null
    return $?
}

function teardown_asymetric_risk_action_test_help() {
    # Nothing yet
    return 0
}

# TRIGGER

function start_auto_tester() {
    local FAILURES=0
    local TESTS_FAILED=()
    stdout_msg 'AUTO' "Starting AsymetricRisk interface auto-tester..."
    log_msg 'DEBUG' "AutoTester Config - ${AR_DEFAULT[@]}"
    for tester_label in ${!AR_AUTO_TESTERS[@]}; do
        stdout_msg 'TEST' "$tester_label"
        local ARGUMENTS=( `${AR_AUTO_TESTERS[${tester_label}]}` )
        stdout_msg 'INFO' "Setting up test case  (${tester_label}) requirements"
        ${AR_AUTO_TESTER_SETUP[${tester_label}]}
        run_init_script ${ARGUMENTS[@]}
        if [ $? -ne 0 ]; then
            local FAILURES=$((FAILURES+1))
            stdout_msg 'NOK' "Test failed! (${tester_label})"
            local TESTS_FAILED=( ${TESTS_FAILED[@]} ${tester_label} )
        else
            stdout_msg 'OK' "Test passed! (${tester_label})"
        fi
        stdout_msg 'INFO' "Cleaning up after test case (${tester_label})"
        ${AR_AUTO_TESTER_TEARDOWN[${tester_label}]}
    done
    if [ $FAILURES -eq 0 ]; then
        stdout_msg 'DONE' "All tests pass!"
    else
        stdout_msg 'WARNING' \
            "(${FAILURES}/${#AR_AUTO_TESTERS[@]}) tests failed!"\
            "Details: ${TESTS_FAILED[@]}"
    fi
    return $FAILURES
}

# DISPLAY

function display_help() {
    cat <<EOF

[ (A)RAT ]: (A)Risk Auto-Tester Usage

    [ Ex ]: Run (A)RAT autotester for interface actions only -

        $ $0

    [ Ex ]: Run (A)RAT autotester for interface actions as well as python3 test
            suit composed of functional and unit tests -

        $ $0 full

EOF
}

# MISCELLANEOUS

EXIT_CODE=1

if [[ "$FULL_TEST_FLAG" == '--help' ]] || [[ "$FULL_TEST_FLAG" == '-h' ]]; then
    display_help
    exit 0
elif [ ! -z "$FULL_TEST_FLAG" ] && [[ "$FULL_TEST_FLAG" != "full" ]]; then
    stdout_msg 'WARNING' "Invalid auto-tester flag! ($FULL_TEST_FLAG) Did you mean (full)?"
    exit $EXIT_CODE
fi

start_auto_tester
EXIT_CODE=$?

if [ ! -z "$FULL_TEST_FLAG" ] && [[ "$FULL_TEST_FLAG" == "full" ]]; then
    python3 -m unittest
    PT_EXIT=$?
    EXIT_CODE=$((EXIT_CODE+$PT_EXIT))
    if [ $PT_EXIT -ne 0 ]; then
        stdout_msg 'WARNING' \
            "Python3 test suit terminated with errors! (${PT_EXIT})"
    fi
fi

if [ $EXIT_CODE -ne 0 ]; then
    stdout_msg 'EXIT' "(${EXIT_CODE})"
fi

exit $EXIT_CODE

# CODE DUMP

