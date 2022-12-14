#!/bin/bash
#
# Regards, the Alveare Solutions society.
#
# DISPLAY

# TODO
function display_usage () {
    echo "[ WARNING ]: Under construction, building..."
    clear; display_header; local FILE_NAME="./`basename $0`"
    cat<<EOF

    [ DESCRIPTION ]: ${NG_SCRIPT_NAME} ${NG_DEFAULT['system-type']} Interface.
    [ USAGE       ]: $FILE_NAME -<option>=<value>

    -h  | --help                   Display this message.

    -S  | --setup                  Setup ${NG_DEFAULT['system-type']} machine.

    [ EXAMPLE     ]:

        $~ $FILE_NAME --setup
        $~ $FILE_NAME

EOF
    return $?
}

function display_bot_ctrl_settings() {
    local ARGUMENTS=( `format_display_bot_ctrl_settings_args` )
    debug_msg "Displaying settings: (${MAGENTA}${ARGUMENTS[@]}${RESET})"
    display_ng_settings ${ARGUMENTS[@]}; echo
    return $?
}

function display_ar_bot_ctrl_settings() {
    local ARGUMENTS=( `format_display_arisk_ctrl_settings_args` )
    debug_msg "Displaying settings: (${MAGENTA}${ARGUMENTS[@]}${RESET})"
    display_ng_settings ${ARGUMENTS[@]} | column; echo
    return $?
}

function display_ar_bot_pid() {
    if [ -f "${MD_DEFAULT['ar-watchdog-pid-file']}" ]; then
        local BOT_PID=`cat ${MD_DEFAULT['ar-watchdog-pid-file']} 2> /dev/null`
        if [ ! -z "$BOT_PID" ]; then
            local DISPLAY_VALUE="${WHITE}${BOT_PID}${RESET}"
        else
            local DISPLAY_VALUE="${RED}Not Running${RESET}"
        fi
    else
        local DISPLAY_VALUE="${RED}Not Running${RESET}"
    fi
    printf "[ ${BLUE}(A)${RED}Risk${CYAN} Bot PID${RESET}          ]: ${DISPLAY_VALUE}\t\n"
    return 0
}

function display_ar_reports() {
    local COUNT=1
    for file_name in `ls ${MD_DEFAULT['ar-report-location']}`; do
        echo "${WHITE}${COUNT}. ${BLUE}${MD_DEFAULT['ar-report-location']}/${YELLOW}${file_name}${RESET}"
        local COUNT=$((COUNT+1))
    done
}

function display_ar_api_key() {
    if [ -z "${MD_DEFAULT['ar-api-key']}" ]; then
        local VALUE="${RED}Not Set${RESET}"
    else
        local VALUE="${GREEN}Locked'n Loaded${RESET}"
    fi
    printf "[ ${CYAN}Binance API KEY${RESET}          ]: ${VALUE}\t\n"
    return $?
}

function display_ar_api_secret() {
    if [ -z "${MD_DEFAULT['ar-api-secret']}" ]; then
        local VALUE="${RED}Not Set${RESET}"
    else
        local VALUE="${GREEN}Locked'n Loaded${RESET}"
    fi
    printf "[ ${CYAN}Binance Secret KEY${RESET}       ]: ${VALUE}\t\n"
    return $?
}

function display_ar_taapi_key() {
    if [ -z "${MD_DEFAULT['ar-taapi-key']}" ]; then
        local VALUE="${RED}Not Set${RESET}"
    else
        local VALUE="${GREEN}Locked'n Loaded${RESET}"
    fi
    printf "[ ${CYAN}Taapi KEY${RESET}                ]: ${VALUE}\t\n"
    return $?
}

function display_ar_rsi_top() {
    printf "[ ${CYAN}RSI Top${RESET}                  ]: ${WHITE}${MD_DEFAULT['ar-rsi-top']}${RESET}/100\t\n"
    return $?
}

function display_ar_rsi_bottom() {
    printf "[ ${CYAN}RSI Bottom${RESET}               ]: ${WHITE}${MD_DEFAULT['ar-rsi-bottom']}${RESET}/100\t\n"
    return $?
}

function display_ar_macd_fast_period() {
    printf "[ ${CYAN}MACD Fast Period${RESET}         ]: ${WHITE}${MD_DEFAULT['ar-macd-fast-period']}${RESET} candles\t\n"
    return $?
}

function display_ar_macd_slow_period() {
    printf "[ ${CYAN}MACD Slow Period${RESET}         ]: ${WHITE}${MD_DEFAULT['ar-macd-slow-period']}${RESET} candles\t\n"
    return $?
}

function display_ar_macd_signal_period() {
    printf "[ ${CYAN}MACD Signal Period${RESET}       ]: ${WHITE}${MD_DEFAULT['ar-macd-signal-period']}${RESET} candles\t\n"
    return $?
}

function display_ar_price_movement() {
    printf "[ ${CYAN}Price Movement${RESET}           ]: ${WHITE}${MD_DEFAULT['ar-price-movement']}${RESET} percent\t\n"
    return $?
}

function display_ar_volume_movement() {
    printf "[ ${CYAN}Volume Movement${RESET}          ]: ${WHITE}${MD_DEFAULT['ar-volume-movement']}${RESET} percent\t\n"
    return $?
}

function display_ar_project_path() {
    printf "[ ${CYAN}Project Path${RESET}             ]: ${BLUE}${MD_DEFAULT['ar-project-path']}${RESET}\t\n"
    return $?
}

function display_ar_conf_file() {
    printf "[ ${CYAN}Config File${RESET}              ]: ${YELLOW}`basename ${MD_DEFAULT['ar-conf-file']}`${RESET}\t\n"
    return $?
}

function display_ar_profit_baby() {
    printf "[ ${CYAN}Profit BABY!!${RESET}            ]: ${WHITE}${MD_DEFAULT['ar-profit-baby']}${RESET} percent\t\n"
    return $?
}

function display_ar_watchdog_pid_file() {
    printf "[ ${CYAN}TradingBot Pid File${RESET}      ]: ${YELLOW}${MD_DEFAULT['ar-watchdog-pid-file']}${RESET}\t\n"
    return $?
}

function display_ar_watchdog_file() {
    printf "[ ${CYAN}TradingBot Anchor File${RESET}   ]: ${YELLOW}${MD_DEFAULT['ar-watchdog-anchor-file']}${RESET}\t\n"
    return $?
}

function display_ar_api_url() {
    printf "[ ${CYAN}Binance URL${RESET}              ]: ${MAGENTA}${MD_DEFAULT['ar-api-url']}${RESET}\t\n"
    return $?
}

function display_ar_taapi_url() {
    printf "[ ${CYAN}Taapi URL${RESET}                ]: ${MAGENTA}${MD_DEFAULT['ar-taapi-url']}${RESET}\t\n"
    return $?
}

function display_ar_max_trades() {
    printf "[ ${CYAN}Max Trades${RESET}               ]: ${WHITE}${MD_DEFAULT['ar-max-trades']}${RESET}/day \t\n"
    return $?
}

function display_ar_trading_account_type() {
    printf "[ ${CYAN}Trading Account Type${RESET}     ]: ${MAGENTA}${MD_DEFAULT['ar-trading-account-type']}${RESET}\t\n"
    return $?
}

function display_ar_trading_order_type() {
    printf "[ ${CYAN}Trading Order Type${RESET}       ]: ${MAGENTA}${MD_DEFAULT['ar-trading-order-type']}${RESET}\t\n"
    return $?
}

function display_ar_order_time_in_force() {
    printf "[ ${CYAN}Order Time in Force${RESET}      ]: ${MAGENTA}${MD_DEFAULT['ar-order-time-in-force']}${RESET}\t\n"
    return $?
}

function display_ar_order_response_type() {
    printf "[ ${CYAN}Order Resp Type${RESET}          ]: ${MAGENTA}${MD_DEFAULT['ar-order-response-type']}${RESET}\t\n"
    return $?
}

function display_ar_order_recv_window() {
    printf "[ ${CYAN}Order Recv Window${RESET}        ]: ${WHITE}${MD_DEFAULT['ar-order-recv-window']}${RESET}\t\n"
    return $?
}

function display_ar_order_price() {
    printf "[ ${CYAN}Order Price${RESET}              ]: ${WHITE}${MD_DEFAULT['ar-order-price']}${RESET}\t\n"
    return $?
}

function display_ar_order_amount() {
    printf "[ ${CYAN}Order Amount${RESET}             ]: ${WHITE}${MD_DEFAULT['ar-order-amount']}${RESET}\t\n"
    return $?
}

function display_ar_stop_loss() {
    printf "[ ${CYAN}Order Stop Loss${RESET}          ]: ${WHITE}${MD_DEFAULT['ar-stop-loss']}${RESET} percent\t\n"
    return $?
}

function display_ar_take_profit() {
    printf "[ ${CYAN}Order Take Profit${RESET}        ]: ${WHITE}${MD_DEFAULT['ar-take-profit']}${RESET} percent\t\n"
    return $?
}

function display_ar_trailing_stop() {
    printf "[ ${CYAN}Order Trailing Stop${RESET}      ]: ${WHITE}${MD_DEFAULT['ar-trailing-stop']}${RESET} percent\t\n"
    return $?
}

function display_ar_test_flag() {
    printf "[ ${CYAN}Test Flag${RESET}                ]: `format_flag_colors ${MD_DEFAULT['ar-test']}`\t\n"
    return $?
}

function display_ar_debug_flag() {
    printf "[ ${CYAN}Debug Flag${RESET}               ]: `format_flag_colors ${MD_DEFAULT['ar-debug']}`\t\n"
    return $?
}

function display_ar_silence_flag() {
    printf "[ ${CYAN}Silence Flag${RESET}             ]: `format_flag_colors ${MD_DEFAULT['ar-silence']}`\t\n"
    return $?
}

function display_ar_analyze_risk_flag() {
    printf "[ ${CYAN}Risk Analysis Flag${RESET}       ]: `format_flag_colors ${MD_DEFAULT['ar-analyze-risk']}`\t\n"
    return $?
}

function display_ar_risk_tolerance() {
    printf "[ ${CYAN}Trading Risk Tolerance${RESET}   ]: ${MAGENTA}${MD_DEFAULT['ar-risk-tolerance']}${RESET}\t\n"
    return $?
}

function display_ar_indicator_update_delay() {
    printf "[ ${CYAN}Indicator API call delay${RESET} ]: ${WHITE}${MD_DEFAULT['ar-indicator-update-delay']} seconds${RESET}\t\n"
    return $?
}

function display_ar_strategy() {
    printf "[ ${CYAN}Trading Strategy${RESET}         ]: ${MAGENTA}${MD_DEFAULT['ar-strategy']}${RESET}\t\n"
    return $?
}

function display_ar_side() {
    printf "[ ${CYAN}Trading Side${RESET}             ]: ${MAGENTA}${MD_DEFAULT['ar-side']}${RESET}\t\n"
    return $?
}

function display_ar_interval() {
    printf "[ ${CYAN}Chart Candle Interval${RESET}    ]: ${WHITE}${MD_DEFAULT['ar-interval']}${RESET}\t\n"
    return $?
}

function display_ar_period() {
    printf "[ ${CYAN}Trading Chart Period${RESET}     ]: ${WHITE}${MD_DEFAULT['ar-period']}${RESET} candles\t\n"
    return $?
}

function display_ar_market_open() {
    printf "[ ${CYAN}Market Open Hours${RESET}        ]: ${MAGENTA}${MD_DEFAULT['ar-market-open']}${RESET}\t\n"
    return $?
}

function display_ar_market_close() {
    printf "[ ${CYAN}Market Close Hours${RESET}       ]: ${MAGENTA}${MD_DEFAULT['ar-market-close']}${RESET}\t\n"
    return $?
}

function display_ar_backtrack() {
    printf "[ ${CYAN}History Backtrack${RESET}        ]: ${WHITE}${MD_DEFAULT['ar-backtrack']}${RESET} candles\t\n"
    return $?
}

function display_ar_backtracks() {
    printf "[ ${CYAN}History Backtracks${RESET}       ]: ${WHITE}${MD_DEFAULT['ar-backtracks']}${RESET} candles\t\n"
    return $?
}

function display_ar_stop_limit() {
    printf "[ ${CYAN}STOP Limit${RESET}               ]: ${WHITE}${MD_DEFAULT['ar-stop-limit']}${RESET} percent\t\n"
    return $?
}

function display_ar_stop_price() {
    printf "[ ${CYAN}STOP Price${RESET}               ]: ${WHITE}${MD_DEFAULT['ar-stop-price']}${RESET} percent\t\n"
    return $?
}

function display_ar_stop_limit_price() {
    printf "[ ${CYAN}STOP LIMIT Time Price${RESET}    ]: ${WHITE}${MD_DEFAULT['ar-stop-limit-time-price']}${RESET}\t\n"
    return $?
}

function displAY_AR_stop_limit_time_in_force() {
    printf "[ ${CYAN}STOP LIMIT Time in Force${RESET} ]: ${MAGENTA}${MD_DEFAULT['ar-stop-limit-time-in-force']}${RESET}\t\n"
    return $?
}

function display_action() {
    printf "[ ${CYAN}Action${RESET}                   ]: ${MAGENTA}${MD_DEFAULT['action']}${RESET}\t\n"
    return $?
}

function display_stock_symbol() {
    printf "[ ${CYAN}Ticker Symbol${RESET}            ]: ${GREEN}${MD_DEFAULT['ticker-symbol']}${RESET}\t\n"
    return $?
}

function display_watch_interval() {
    printf "[ ${CYAN}Watch Interval${RESET}           ]: ${WHITE}${MD_DEFAULT['watch-interval']}${RESET} seconds\t\n"
    return $?
}

function display_watch_flag() {
    printf "[ ${CYAN}Watch Flag${RESET}               ]: `format_flag_colors ${MD_DEFAULT['watch-flag']}`\t\n"
    return $?
}

function display_watch_anchor_file() {
    printf "[ ${CYAN}Watch Anchor File${RESET}        ]: ${BLUE}`dirname ${MD_DEFAULT['watch-anchor-file']}`/${YELLOW}`basename ${MD_DEFAULT['watch-anchor-file']}`${RESET}\t\n"
    return $?
}

function display_period() {
    printf "[ ${CYAN}Period${RESET}                   ]: ${MAGENTA}${MD_DEFAULT['period']}${RESET}\t\n"
    return $?
}

function display_period_interval() {
    printf "[ ${CYAN}Period Interval${RESET}          ]: ${MAGENTA}${MD_DEFAULT['period-interval']}${RESET}\t\n"
    return $?
}

function display_period_start() {
    printf "[ ${CYAN}Period START Date${RESET}        ]: ${MAGENTA}${MD_DEFAULT['period-start']}${RESET}\t\n"
    return $?
}

function display_period_end() {
    printf "[ ${CYAN}Period END Date${RESET}          ]: ${MAGENTA}${MD_DEFAULT['period-end']}${RESET}\t\n"
    return $?
}

function display_action_header() {
    printf "[ ${CYAN}Action Header Flag${RESET}       ]: `format_flag_colors ${MD_DEFAULT['action-header']}`\t\n"
    return $?
}

function display_write_flag() {
    printf "[ ${CYAN}Write Flag${RESET}               ]: `format_flag_colors ${MD_DEFAULT['write-flag']}`\t\n"
    return $?
}

function display_write_mode() {
    printf "[ ${CYAN}Write Mode${RESET}               ]: ${MAGENTA}${MD_DEFAULT['write-mode']}${RESET}\t\n"
    return $?
}

function display_out_file() {
    printf "[ ${CYAN}Out File${RESET}                 ]: ${BLUE}`dirname ${MD_DEFAULT['out-file']}`/${YELLOW}`basename ${MD_DEFAULT['out-file']}`${RESET}\t\n"
    return $?
}

function display_action_target() {
    printf "[ ${CYAN}Action Target${RESET}            ]: ${MAGENTA}${MD_DEFAULT['action-target']}${RESET}\t\n"
    return $?
}

function display_base_currency() {
    printf "[ ${CYAN}Base Currency${RESET}            ]: ${GREEN}${MD_DEFAULT['base-currency']}${RESET}\t\n"
    return $?
}

function display_exchange_currency() {
    printf "[ ${CYAN}Quote Currency${RESET}           ]: ${GREEN}${MD_DEFAULT['quote-currency']}${RESET}\t\n"
    return $?
}

function display_crypto_topx() {
    printf "[ ${CYAN}Crypto TopX${RESET}              ]: ${WHITE}${MD_DEFAULT['crypto-topx']}${RESET}\t\n"
    return $?
}

function display_quantity() {
    printf "[ ${CYAN}Currency Quantity${RESET}        ]: ${WHITE}${MD_DEFAULT['quantity']}${RESET}\t\n"
    return $?
}

function display_local_ipv4_address () {
    local LOCAL_IPV4=`fetch_local_ipv4_address`
    local TRIMMED_STDOUT=`echo -n ${LOCAL_IPV4} | sed 's/\[ WARNING \]: //g'`
    if [[ "${TRIMMED_STDOUT}" =~ "No LAN access!" ]]; then
        local DISPLAY_VALUE="${RED}Unknown${RESET}"
    else
        local DISPLAY_VALUE="${MAGENTA}$LOCAL_IPV4${RESET}"
    fi
    printf "[ ${CYAN}Local IPv4${RESET}               ]: ${DISPLAY_VALUE}\t\n"
    return $?
}

function display_external_ipv4_address () {
    local EXTERNAL_IPV4="`fetch_external_ipv4_address`"
    local EXIT_CODE=$?
    local TRIMMED_STDOUT=`echo -n ${EXTERNAL_IPV4} | sed 's/\[ WARNING \]: //g'`
    if [ $EXIT_CODE -ne 0 ] || [[ "${TRIMMED_STDOUT}" =~ "No internet access!" ]]; then
        local DISPLAY_VALUE="${RED}Unknown${RESET}"
    else
        local DISPLAY_VALUE="${MAGENTA}$EXTERNAL_IPV4${RESET}"
    fi
    printf "[ ${CYAN}External IPv4${RESET}            ]: ${DISPLAY_VALUE}\t\n"
    return $?
}

function display_setting_project_path () {
    printf "[ ${CYAN}Project Path${RESET}             ]: ${BLUE}${MD_DEFAULT['project-path']}${RESET}\t\n"
    return $?
}

function display_setting_log_dir_path () {
    printf "[ ${CYAN}Log Dir${RESET}                  ]: ${BLUE}${MD_DEFAULT['log-dir']}${RESET}\t\n"
    return $?
}

function display_setting_conf_dir_path () {
    printf "[ ${CYAN}Conf Dir${RESET}                 ]: ${BLUE}${MD_DEFAULT['conf-dir']}${RESET}\t\n"
    return $?
}

function display_setting_cron_dir_path () {
    printf "[ ${CYAN}Cron Dir${RESET}                 ]: ${BLUE}${MD_DEFAULT['cron-dir']}${RESET}\t\n"
    return $?
}

function display_setting_log_file_path () {
    printf "[ ${CYAN}Log File${RESET}                 ]: ${BLUE}`dirname ${MD_DEFAULT['log-file']}`/${YELLOW}`basename ${NG_DEFAULT['log-file']}`${RESET}\t\n"
    return $?
}

function display_setting_conf_file_path () {
    printf "[ ${CYAN}Conf File${RESET}                ]: ${BLUE}`dirname ${MD_DEFAULT['conf-file']}`/${YELLOW}`basename ${NG_DEFAULT['conf-file']}`${RESET}\t\n"
    return $?
}

function display_setting_conf_json_file_path () {
    printf "[ ${CYAN}Conf JSON${RESET}                ]: ${BLUE}`dirname ${MD_DEFAULT['conf-json-file']}`/${YELLOW}`basename ${NG_DEFAULT['conf-json-file']}`${RESET}\t\n"
    return $?
}

function display_setting_log_lines () {
    printf "[ ${CYAN}Log Lines${RESET}                ]: ${WHITE}${MD_DEFAULT['log-lines']}${RESET}\t\n"
    return $?
}

function display_setting_system_user () {
    printf "[ ${CYAN}System User${RESET}              ]: ${YELLOW}${MD_DEFAULT['system-user']}${RESET}\t\n"
    return $?
}

function display_setting_system_pass () {
    if [ -z "${MD_DEFAULT['system-pass']}" ]; then
        local VALUE="${RED}Not Set${RESET}"
    else
        local VALUE="${GREEN}Locked'n Loaded${RESET}"
    fi
    printf "[ ${CYAN}User PSK${RESET}                 ]: $VALUE\t\n"
    return $?
}

function display_setting_system_perms () {
    printf "[ ${CYAN}File Perms${RESET}               ]: ${WHITE}${MD_DEFAULT['system-perms']}${RESET}\t\n"
    return $?
}

function display_setting_hostname_file () {
    printf "[ ${CYAN}Hostname File${RESET}            ]: ${BLUE}`dirname ${MD_DEFAULT['hostname-file']}`/${YELLOW}`basename ${NG_DEFAULT['hostname-file']}`${RESET}\t\n"
    return $?
}

function display_setting_hosts_file () {
    printf "[ ${CYAN}Hosts File${RESET}               ]: ${BLUE}`dirname ${MD_DEFAULT['hosts-file']}`/${YELLOW}`basename ${NG_DEFAULT['hosts-file']}`${RESET}\t\n"
    return $?
}

function display_setting_wpa_file () {
    printf "[ ${CYAN}WPA Supplicant Conf${RESET}      ]: ${BLUE}`dirname ${MD_DEFAULT['wpa-file']}`/${YELLOW}`basename ${NG_DEFAULT['wpa-file']}`${RESET}\t\n"
    return $?
}

function display_setting_cron_file () {
    printf "[ ${CYAN}Cron File${RESET}                ]: ${BLUE}`dirname ${MD_DEFAULT['cron-file']}`/${YELLOW}`basename ${NG_DEFAULT['cron-file']}`${RESET}\t\n"
    return $?
}

function display_setting_bashrc_file () {
    printf "[ ${CYAN}BashRC File${RESET}              ]: ${BLUE}`dirname ${MD_DEFAULT['bashrc-file']}`/${YELLOW}`basename ${NG_DEFAULT['bashrc-file']}`${RESET}\t\n"
    return $?
}

function display_setting_bashaliases_file () {
    printf "[ ${CYAN}BashAliases File${RESET}         ]: ${BLUE}`dirname ${MD_DEFAULT['bashaliases-file']}`/${YELLOW}`basename ${NG_DEFAULT['bashaliases-file']}`${RESET}\t\n"
    return $?
}

function display_setting_bashrc_template () {
    printf "[ ${CYAN}BashRC Template${RESET}          ]: ${BLUE}`dirname ${MD_DEFAULT['bashrc-template']}`/${YELLOW}`basename ${NG_DEFAULT['bashrc-template']}`${RESET}\t\n"
    return $?
}

function display_setting_silence_flag () {
    printf "[ ${CYAN}Silence${RESET}                  ]: `format_flag_colors ${MD_DEFAULT['silence']}`\t\n"
    return $?
}

function display_setting_wifi_essid () {
    printf "[ ${CYAN}WiFi ESSID${RESET}               ]: ${MAGENTA}${MD_DEFAULT['wifi-essid']}${RESET}\t\n"
    return $?
}

function display_setting_wifi_pass () {
    if [ -z "${NG_DEFAULT['wifi-pass']}" ]; then
        local VALUE="${RED}Not Set${RESET}"
    else
        local VALUE="${GREEN}Locked'n Loaded${RESET}"
    fi
    printf "[ ${CYAN}WiFi PSK${RESET}                 ]: $VALUE\t\n"
    return $?
}

function display_wpa_supplicant_dir() {
    printf "[ ${CYAN}WPA Supplicant Dir${RESET}       ]: ${BLUE}`dirname ${MD_DEFAULT['wpa-file']}`${RESET}\t\n"
    return $?
}

function display_hosts_dir() {
    printf "[ ${CYAN}Hosts Dir${RESET}                ]: ${BLUE}`dirname ${MD_DEFAULT['hosts-file']}`${RESET}\t\n"
    return $?
}

function display_hostname_dir() {
    printf "[ ${CYAN}Hostname Dir${RESET}             ]: ${BLUE}`dirname ${MD_DEFAULT['hostname-file']}`${RESET}\t\n"
    return $?
}

function display_data_dir() {
    printf "[ ${CYAN}Data Dir${RESET}                 ]: ${BLUE}${MD_DEFAULT['dta-dir']}${RESET}\t\n"
    return $?
}

function display_analysis_ctrl_settings() {
    local ARGUMENTS=( `format_display_analysis_ctrl_settings_args` )
    debug_msg "Displaying settings: (${MAGENTA}${ARGUMENTS[@]}${RESET})"
    display_ng_settings ${ARGUMENTS[@]} | column && echo
    return $?
}

function display_main_settings () {
    local ARGUMENTS=( `format_display_main_settings_args` )
    debug_msg "Displaying settings: (${MAGENTA}${ARGUMENTS[@]}${RESET})"
    display_ng_settings ${ARGUMENTS[@]} && echo
    return $?
}

function display_project_settings () {
    local ARGUMENTS=( `format_display_project_settings_args` )
    debug_msg "Displaying settings: (${MAGENTA}${ARGUMENTS[@]}${RESET})"
    display_ng_settings ${ARGUMENTS[@]} | column && echo
    return $?
}

function display_banners () {
    if [ -z "${MD_DEFAULT['banner']}" ]; then
        return 1
    fi
    case "${MD_DEFAULT['banner']}" in
        *','*)
            for cargo_key in `echo ${MD_DEFAULT['banner']} | sed 's/,/ /g'`; do
                ${MD_CARGO[$cargo_key]} "${MD_DEFAULT['conf-file']}" 2> /dev/null
            done
            ;;
        *)
            ${MD_CARGO[${MD_DEFAULT['banner']}]} "${MD_DEFAULT['conf-file']}" 2> /dev/null
            ;;
    esac
    return $?
}

function display_header () {
    cat <<EOF
    ___________________________________________________________________________

     *                        *   ${BLUE}${NG_SCRIPT_NAME}${RESET}  *                       *
    ___________________________________________________________________________
               Excellent Regards, the Alveare Solutions #!/Society -x
EOF
    return $?
}

function display_ng_settings () {
    local SETTING_LABELS=( $@ )
    for setting in ${SETTING_LABELS[@]}; do
        case "$setting" in
            'project-path')
                display_setting_project_path; continue
                ;;
            'log-dir')
                display_setting_log_dir_path; continue
                ;;
            'conf-dir')
                display_setting_conf_dir_path; continue
                ;;
            'cron-dir')
                display_setting_cron_dir_path; continue
                ;;
            'log-file')
                display_setting_log_file_path; continue
                ;;
            'conf-file')
                display_setting_conf_file_path; continue
                ;;
            'conf-json-file')
                display_setting_conf_json_file_path; continue
                ;;
            'log-lines')
                display_setting_log_lines; continue
                ;;
            'system-user')
                display_setting_system_user; continue
                ;;
            'system-pass')
                display_setting_system_pass; continue
                ;;
            'system-perms')
                display_setting_system_perms; continue
                ;;
            'hostname-file')
                display_setting_hostname_file; continue
                ;;
            'hosts-file')
                display_setting_hosts_file; continue
                ;;
            'wpa-file')
                display_setting_wpa_file; continue
                ;;
            'cron-file')
                display_setting_cron_file; continue
                ;;
            'bashrc-file')
                display_setting_bashrc_file; continue
                ;;
            'bashaliases-file')
                display_setting_bashaliases_file; continue
                ;;
            'bashrc-template')
                display_setting_bashrc_template; continue
                ;;
            'silence')
                display_setting_silence_flag; continue
                ;;
            'local-ip')
                display_local_ipv4_address; continue
                ;;
            'external-ip')
                display_external_ipv4_address; continue
                ;;
            'wifi-essid')
                display_setting_wifi_essid; continue
                ;;
            'wifi-pass')
                display_setting_wifi_pass; continue
                ;;
            'wpa-dir')
                display_wpa_supplicant_dir; continue
                ;;
            'hosts-dir')
                display_hosts_dir; continue
                ;;
            'hostname-dir')
                display_hostname_dir; continue
                ;;
            'data-dir')
                display_data_dir; continue
                ;;
            'action')
                display_action; continue
                ;;
            'ticker-symbol')
                display_stock_symbol; continue
                ;;
            'watch-interval')
                display_watch_interval; continue
                ;;
            'watch-flag')
                display_watch_flag; continue
                ;;
            'watch-anchor-file')
                display_watch_anchor_file; continue
                ;;
            'period')
                display_period; continue
                ;;
            'period-interval')
                display_period_interval; continue
                ;;
            'period-start')
                display_period_start; continue
                ;;
            'period-end')
                display_period_end; continue
                ;;
            'action-header')
                display_action_header; continue
                ;;
            'write-flag')
                display_write_flag; continue
                ;;
            'write-mode')
                display_write_mode; continue
                ;;
            'out-file')
                display_out_file; continue
                ;;
            'action-target')
                display_action_target; continue
                ;;
            'base-currency')
                display_base_currency; continue
                ;;
            'exchange-currency')
                display_exchange_currency; continue
                ;;
            'crypto-topx')
                display_crypto_topx; continue
                ;;
            'quantity')
                display_quantity; continue
                ;;
            "ar-project-path")
                display_ar_project_path; continue
                ;;
            "ar-conf-file")
                display_ar_conf_file; continue
                ;;
            "ar-profit-baby")
                display_ar_profit_baby; continue
                ;;
            "ar-watchdog-pid-file")
                display_ar_watchdog_pid_file; continue
                ;;
            "ar-watchdog-anchor-file")
                display_ar_watchdog_file; continue
                ;;
            "ar-api-key")
                display_ar_api_key; continue
                ;;
            "ar-api-secret")
                display_ar_api_secret; continue
                ;;
            "ar-taapi-key")
                display_ar_taapi_key; continue
                ;;
            "ar-api-url")
                display_ar_api_url; continue
                ;;
            "ar-taapi-url")
                display_ar_taapi_url; continue
                ;;
            "ar-max-trades")
                display_ar_max_trades; continue
                ;;
            "ar-trading-account-type")
                display_ar_trading_account_type; continue
                ;;
            "ar-trading-order-type")
                display_ar_trading_order_type; continue
                ;;
            "ar-order-time-in-force")
                display_ar_order_time_in_force; continue
                ;;
            "ar-order-response-type")
                display_ar_order_response_type; continue
                ;;
            "ar-order-recv-window")
                display_ar_order_recv_window; continue
                ;;
            "ar-order-price")
                display_ar_order_price; continue
                ;;
            "ar-order-amount")
                display_ar_order_amount; continue
                ;;
            "ar-stop-loss")
                display_ar_stop_loss; continue
                ;;
            "ar-take-profit")
                display_ar_take_profit; continue
                ;;
            "ar-trailing-stop")
                display_ar_trailing_stop; continue
                ;;
            "ar-test")
                display_ar_test_flag; continue
                ;;
            "ar-debug")
                display_ar_debug_flag; continue
                ;;
            "ar-silence")
                display_ar_silence_flag; continue
                ;;
            "ar-analyze-risk")
                display_ar_analyze_risk_flag; continue
                ;;
            "ar-risk-tolerance")
                display_ar_risk_tolerance; continue
                ;;
            "ar-indicator-update-delay")
                display_ar_indicator_update_delay; continue
                ;;
            "ar-strategy")
                display_ar_strategy; continue
                ;;
            "ar-side")
                display_ar_side; continue
                ;;
            "ar-interval")
                display_ar_interval; continue
                ;;
            "ar-period")
                display_ar_period; continue
                ;;
            "ar-market-open")
                display_ar_market_open; continue
                ;;
            "ar-market-close")
                display_ar_market_close; continue
                ;;
            "ar-backtrack")
                display_ar_backtrack; continue
                ;;
            "ar-backtracks")
                display_ar_backtracks; continue
                ;;
            "ar-stop-limit")
                display_ar_stop_limit; continue
                ;;
            "ar-stop-price")
                display_ar_stop_price; continue
                ;;
            "ar-stop-limit-price")
                display_ar_stop_limit_price; continue
                ;;
            "ar-stop-limit-time-in-force")
                display_ar_stop_limit_time_in_force; continue
                ;;
            'ar-rsi-top')
                display_ar_rsi_top; continue
                ;;
            'ar-rsi-bottom')
               display_ar_rsi_bottom; continue
               ;;
            'ar-macd-fast-period')
               display_ar_macd_fast_period; continue
               ;;
            'ar-macd-slow-period')
               display_ar_macd_slow_period; continue
               ;;
            'ar-macd-signal-period')
               display_ar_macd_signal_period; continue
               ;;
            'ar-price-movement')
               display_ar_price_movement; continue
               ;;
            'ar-volume-movement')
                display_ar_volume_movement; continue
                ;;
            'ar-pid')
                display_ar_bot_pid; continue
                ;;
        esac
    done
    return 0
}

# CODE DUMP

