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
        esac
    done
    return 0
}

function display_action() {
    printf "[ ${CYAN}Action${RESET}                   ]: ${MAGENTA}${MD_DEFAULT['action']}${RESET}\t\n"
    return $?
}

function display_stock_symbol() {
    printf "[ ${CYAN}Stock Symbol${RESET}             ]: ${GREEN}${MD_DEFAULT['ticker-symbol']}${RESET}\t\n"
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

function display_bot_ctrl_settings() {
    local ARGUMENTS=( `format_display_bot_ctrl_settings_args` )
    debug_msg "Displaying settings: (${MAGENTA}${ARGUMENTS[@]}${RESET})"
    display_ng_settings ${ARGUMENTS[@]} && echo
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
                      Regards, the Alveare Solutions #!/Society -x
EOF
    return $?
}


# CODE DUMP


