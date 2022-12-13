#!/bin/bash
#
# Regards, the Alveare Solutions #!/Society -x
#
# SETUP

# LOADERS

function load_project_config () {
    load_project_logging_levels
    load_project_script_name
    load_project_prompt_string
    load_project_defaults
    load_project_cargo
    load_project_dependencies
}

function load_project_dependencies () {
    load_apt_dependencies ${NG_APT_DEPENDENCIES[@]}
    load_pip3_dependencies ${NG_PIP3_DEPENDENCIES[@]}
    return $?
}

function load_project_prompt_string () {
    load_prompt_string "$NG_PS3"
    return $?
}

function load_project_logging_levels () {
    load_logging_levels ${NG_LOGGING_LEVELS[@]}
    return $?
}

function load_project_cargo () {
    for project_cargo in ${!NG_CARGO[@]}; do
        load_cargo \
            "$project_cargo" ${NG_CARGO[$project_cargo]}
    done
    return $?
}

function load_project_defaults () {
    for project_setting in ${!NG_DEFAULT[@]}; do
        load_default_setting \
            "$project_setting" ${NG_DEFAULT[$project_setting]}
    done
    return $?
}

function load_project_script_name () {
    load_script_name "$NG_SCRIPT_NAME"
    return $?
}

# PROJECT SETUP

function project_setup () {
    lock_and_load
    load_project_config
    create_project_menu_controllers
    setup_project_menu_controllers
    cleanup_pid_files
}

function setup_project_menu_controllers () {
    if [ $EUID -eq 0 ]; then
        fetch_ultimatum_from_user 'Super User privileges detected! Setup dependencies? [Y/N]'
        if [ $? -eq 0 ]; then
            setup_project_dependencies
        else
            info_msg 'Skipping dependency setup.'
        fi
    fi
    setup_main_menu_controller
    setup_bot_ctrl_menu_controller
    setup_ar_bot_ctrl_menu_controller
    setup_astrology_ctrl_menu_controller
    setup_log_viewer_menu_controller
    setup_settings_menu_controller
    done_msg "${BLUE}$SCRIPT_NAME${RESET} controller setup complete."
    return 0
}

# SETUP DEPENDENCIES

function setup_project_dependencies () {
    apt_install_dependencies
    pip3_install_dependencies
    return $?
}

# BOT CTRL SETUP

function setup_bot_ctrl_menu_controller() {
    setup_bot_ctrl_menu_option_asymetric_risk
    setup_bot_ctrl_menu_option_back
    done_msg "(${CYAN}$BOT_CONTROLLER_LABEL${RESET}) controller"\
        "option binding complete."
    return 0
}

function setup_bot_ctrl_menu_option_asymetric_risk() {
    setup_menu_controller_menu_option \
        "$BOT_CONTROLLER_LABEL"  'Asymetric-Risk' \
        "$AR_CONTROLLER_LABEL"
    return $?
}

function setup_bot_ctrl_menu_option_back() {
    setup_menu_controller_action_option \
        "$BOT_CONTROLLER_LABEL"  'Back' 'action_back'
    return $?
}

# (A)Risk BOT CTRL SETUP

function setup_ar_bot_ctrl_menu_controller() {
    setup_ar_bot_ctrl_menu_option_start_bot_foreground
    setup_ar_bot_ctrl_menu_option_start_bot_background
    setup_ar_bot_ctrl_menu_option_stop_bot
    setup_ar_bot_ctrl_menu_option_check_bot_running
    setup_ar_bot_ctrl_menu_option_report_list
    setup_ar_bot_ctrl_menu_option_report_all
    setup_ar_bot_ctrl_menu_option_report_trading_history
    setup_ar_bot_ctrl_menu_option_report_deposit_history
    setup_ar_bot_ctrl_menu_option_report_withdrawal_history
    setup_ar_bot_ctrl_menu_option_report_success_rate
    setup_ar_bot_ctrl_menu_option_edit_bot_config
    setup_ar_bot_ctrl_menu_option_view_bot_config
    setup_ar_bot_ctrl_menu_option_view_report
    setup_ar_bot_ctrl_menu_option_view_market_details
    setup_ar_bot_ctrl_menu_option_view_account_details
    setup_ar_bot_ctrl_menu_option_remove_reports
    setup_ar_bot_ctrl_menu_option_back
    done_msg "(${CYAN}$AR_CONTROLLER_LABEL${RESET}) controller"\
        "option binding complete."
    return 0
}

function setup_ar_bot_ctrl_menu_option_remove_reports() {
    setup_menu_controller_action_option \
        "$AR_CONTROLLER_LABEL" 'Remove-Reports' \
        'action_ar_remove_reports'
    return $?
}

function setup_ar_bot_ctrl_menu_option_edit_bot_config() {
    setup_menu_controller_action_option \
        "$AR_CONTROLLER_LABEL" 'Edit-Bot-Config' \
        'action_ar_edit_bot_config'
    return $?
}

function setup_ar_bot_ctrl_menu_option_start_bot_foreground() {
    setup_menu_controller_action_option \
        "$AR_CONTROLLER_LABEL" 'Start-Bot-Foreground' \
        'action_ar_start_bot_in_foreground'
    return $?
}

function setup_ar_bot_ctrl_menu_option_start_bot_background() {
    setup_menu_controller_action_option \
        "$AR_CONTROLLER_LABEL" 'Start-Bot-Background' \
        'action_ar_start_bot_in_background'
    return $?
}

function setup_ar_bot_ctrl_menu_option_stop_bot() {
    setup_menu_controller_action_option \
        "$AR_CONTROLLER_LABEL" 'Stop-Bot' \
        'action_ar_stop_bot'
    return $?
}

function setup_ar_bot_ctrl_menu_option_check_bot_running() {
    setup_menu_controller_action_option \
        "$AR_CONTROLLER_LABEL" 'Check-Bot-Running' \
        'action_ar_check_bot_running'
    return $?
}

function setup_ar_bot_ctrl_menu_option_report_list() {
    setup_menu_controller_action_option \
        "$AR_CONTROLLER_LABEL" 'Report-List' \
        'action_ar_report_list'
    return $?
}

function setup_ar_bot_ctrl_menu_option_report_all() {
    setup_menu_controller_action_option \
        "$AR_CONTROLLER_LABEL" 'Report-All' \
        'action_ar_report_all'
    return $?
}

function setup_ar_bot_ctrl_menu_option_report_trading_history() {
    setup_menu_controller_action_option \
        "$AR_CONTROLLER_LABEL" 'Report-Trading-History' \
        'action_ar_report_trading_history'
    return $?
}

function setup_ar_bot_ctrl_menu_option_report_deposit_history() {
    setup_menu_controller_action_option \
        "$AR_CONTROLLER_LABEL" 'Report-Deposit-History' \
        'action_ar_report_deposit_history'
    return $?
}

function setup_ar_bot_ctrl_menu_option_report_withdrawal_history() {
    setup_menu_controller_action_option \
        "$AR_CONTROLLER_LABEL" 'Report-Withdrawal-History' \
        'action_ar_report_withdrawal_history'
    return $?
}

function setup_ar_bot_ctrl_menu_option_report_success_rate() {
    setup_menu_controller_action_option \
        "$AR_CONTROLLER_LABEL" 'Report-Success-Rate' \
        'action_ar_report_success_rate'
    return $?
}

function setup_ar_bot_ctrl_menu_option_view_bot_config() {
    setup_menu_controller_action_option \
        "$AR_CONTROLLER_LABEL" 'View-Bot-Config' \
        'action_ar_view_bot_config'
    return $?
}

function setup_ar_bot_ctrl_menu_option_view_report() {
    setup_menu_controller_action_option \
        "$AR_CONTROLLER_LABEL" 'View-Report' \
        'action_ar_view_report'
    return $?
}

function setup_ar_bot_ctrl_menu_option_view_market_details() {
    setup_menu_controller_action_option \
        "$AR_CONTROLLER_LABEL" 'View-Market-Details' \
        'action_ar_view_market_details'
    return $?
}

function setup_ar_bot_ctrl_menu_option_view_account_details() {
    setup_menu_controller_action_option \
        "$AR_CONTROLLER_LABEL" 'View-Account-Details' \
        'action_ar_view_account_details'
    return $?
}

function setup_ar_bot_ctrl_menu_option_back() {
    setup_menu_controller_action_option \
        "$AR_CONTROLLER_LABEL" 'Back' 'action_back'
    return $?
}

# ASTROLOGY CTRL SETUP

function setup_astrology_ctrl_menu_controller() {
    setup_astrology_ctrl_menu_option_crypto_topx
    setup_astrology_ctrl_menu_option_currency_chart
    setup_astrology_ctrl_menu_option_stock_price_history
    setup_astrology_ctrl_menu_option_stock_recommendations
    setup_astrology_ctrl_menu_option_stock_info
    setup_astrology_ctrl_menu_option_stock_price_open
    setup_astrology_ctrl_menu_option_stock_price_close
    setup_astrology_ctrl_menu_option_stock_price_high
    setup_astrology_ctrl_menu_option_stock_price_low
    setup_astrology_ctrl_menu_option_stock_volume
    setup_astrology_ctrl_menu_option_company_calendar
    setup_astrology_ctrl_menu_option_show_supported_currencies
    setup_astrology_ctrl_menu_option_show_supported_crypto
    setup_astrology_ctrl_menu_option_currency_convertor
    setup_astrology_ctrl_menu_option_back
    done_msg "(${CYAN}$ANALYSIS_CONTROLLER_LABEL${RESET}) controller"\
        "option binding complete."
    return 0
}

function setup_astrology_ctrl_menu_option_currency_convertor() {
    setup_menu_controller_action_option \
        "$ANALYSIS_CONTROLLER_LABEL"  'Currency-Convertor'\
        'action_currency_convertor'
    return $?
}

function setup_astrology_ctrl_menu_option_crypto_topx() {
    setup_menu_controller_action_option \
        "$ANALYSIS_CONTROLLER_LABEL"  'Crypto-TopX' 'action_crypto_topx'
    return $?
}

function setup_astrology_ctrl_menu_option_currency_chart() {
    setup_menu_controller_action_option \
        "$ANALYSIS_CONTROLLER_LABEL"  'Currency-Chart' 'action_currency_chart'
    return $?
}

function setup_astrology_ctrl_menu_option_stock_price_history() {
    setup_menu_controller_action_option \
        "$ANALYSIS_CONTROLLER_LABEL"  'Stock-Price-History' \
        'action_stock_price_history'
    return $?
}

function setup_astrology_ctrl_menu_option_stock_recommendations() {
    setup_menu_controller_action_option \
        "$ANALYSIS_CONTROLLER_LABEL"  'Stock-Recommendations' \
        'action_stock_recommendations'
    return $?
}

function setup_astrology_ctrl_menu_option_stock_info() {
    setup_menu_controller_action_option \
        "$ANALYSIS_CONTROLLER_LABEL"  'Stock-Info' \
        'action_stock_info'
    return $?
}

function setup_astrology_ctrl_menu_option_stock_price_open() {
    setup_menu_controller_action_option \
        "$ANALYSIS_CONTROLLER_LABEL"  'Stock-Price-Open' \
        'action_stock_price_open'
    return $?
}

function setup_astrology_ctrl_menu_option_stock_price_close() {
    setup_menu_controller_action_option \
        "$ANALYSIS_CONTROLLER_LABEL"  'Stock-Price-Close' \
        'action_stock_price_close'
    return $?
}

function setup_astrology_ctrl_menu_option_stock_price_high() {
    setup_menu_controller_action_option \
        "$ANALYSIS_CONTROLLER_LABEL"  'Stock-Price-High' \
        'action_stock_price_high'
    return $?
}

function setup_astrology_ctrl_menu_option_stock_price_low() {
    setup_menu_controller_action_option \
        "$ANALYSIS_CONTROLLER_LABEL"  'Stock-Price-Low' \
        'action_stock_price_low'
    return $?
}

function setup_astrology_ctrl_menu_option_stock_volume() {
    setup_menu_controller_action_option \
        "$ANALYSIS_CONTROLLER_LABEL"  'Stock-Volume' 'action_stock_volume'
    return $?
}

function setup_astrology_ctrl_menu_option_company_calendar() {
    setup_menu_controller_action_option \
        "$ANALYSIS_CONTROLLER_LABEL"  'Company-Calendar' \
        'action_company_calendar'
    return $?
}

function setup_astrology_ctrl_menu_option_show_supported_currencies() {
    setup_menu_controller_action_option \
        "$ANALYSIS_CONTROLLER_LABEL"  'Show-Supported-Currencies' \
        'action_show_supported_currencies'
    return $?
}

function setup_astrology_ctrl_menu_option_show_supported_crypto() {
    setup_menu_controller_action_option \
        "$ANALYSIS_CONTROLLER_LABEL"  'Show-Supported-Crypto' \
        'action_show_supported_crypto'
    return $?
}

function setup_astrology_ctrl_menu_option_back () {
    setup_menu_controller_action_option \
        "$ANALYSIS_CONTROLLER_LABEL"  'Back' 'action_back'
    return $?
}

# LOG VIEWER SETUP

function setup_log_viewer_menu_controller () {
    setup_log_viewer_menu_option_display_tail
    setup_log_viewer_menu_option_display_head
    setup_log_viewer_menu_option_display_more
    setup_log_viewer_menu_option_clear_log
    setup_log_viewer_menu_option_back
    done_msg "(${CYAN}$LOGVIEWER_CONTROLLER_LABEL${RESET}) controller"\
        "option binding complete."
    return 0
}

function setup_log_viewer_menu_option_clear_log () {
    setup_menu_controller_action_option \
        "$LOGVIEWER_CONTROLLER_LABEL"  'Clear-Log' 'action_clear_log_file'
    return $?
}

function setup_log_viewer_menu_option_display_tail () {
    setup_menu_controller_action_option \
        "$LOGVIEWER_CONTROLLER_LABEL"  'Display-Tail' 'action_log_view_tail'
    return $?
}

function setup_log_viewer_menu_option_display_head () {
    setup_menu_controller_action_option \
        "$LOGVIEWER_CONTROLLER_LABEL"  'Display-Head' 'action_log_view_head'
    return $?
}

function setup_log_viewer_menu_option_display_more () {
    setup_menu_controller_action_option \
        "$LOGVIEWER_CONTROLLER_LABEL"  'Display-More' 'action_log_view_more'
    return $?
}

function setup_log_viewer_menu_option_back () {
    setup_menu_controller_action_option \
        "$LOGVIEWER_CONTROLLER_LABEL"  'Back' 'action_back'
    return $?
}

# SETTINGS SETUP

function setup_settings_menu_controller () {
    setup_settings_menu_option_set_conf_file
    setup_settings_menu_option_set_conf_json
    setup_settings_menu_option_set_wpa_supplicant_file
    setup_settings_menu_option_set_bashrc_file
    setup_settings_menu_option_set_bashrc_template
    setup_settings_menu_option_set_bashaliases_file
    setup_settings_menu_option_set_hostname_file
    setup_settings_menu_option_set_hosts_file
    setup_settings_menu_option_set_cron_file
    setup_settings_menu_option_set_wifi_essid
    setup_settings_menu_option_set_wifi_pass
    setup_settings_menu_option_set_system_user
    setup_settings_menu_option_set_system_password
    setup_settings_menu_option_set_system_permsissions
    setup_settings_menu_option_update_conf_json
    setup_settings_menu_option_update_bot_conf_json
    setup_settings_menu_option_set_silent_flag
    setup_settings_menu_option_set_log_file
    setup_settings_menu_option_set_log_lines
    setup_settings_menu_option_set_quantity
    setup_settings_menu_option_install_dependencies
    setup_settings_menu_option_set_watch_flag
    setup_settings_menu_option_set_write_flag
    setup_settings_menu_option_set_action_header_flag
    setup_settings_menu_option_set_stock_symbol
    setup_settings_menu_option_set_base_currency
    setup_settings_menu_option_set_exchange_currency
    setup_settings_menu_option_set_watch_interval
    setup_settings_menu_option_set_watch_anchor_file
    setup_settings_menu_option_set_period
    setup_settings_menu_option_set_period_interval
    setup_settings_menu_option_set_period_start
    setup_settings_menu_option_set_period_end
    setup_settings_menu_option_set_write_mode
    setup_settings_menu_option_set_out_file
    setup_settings_menu_option_set_action_target
    setup_settings_menu_option_set_crypto_topx
    setup_settings_menu_option_setup_machine
    setup_settings_menu_option_back
    done_msg "(${CYAN}$SETTINGS_CONTROLLER_LABEL${RESET}) controller"\
        "option binding complete."
    return 0
}

function setup_settings_menu_option_set_watch_flag() {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Watch-FLAG' \
        'action_set_watch_flag'
    return $?
}

function setup_settings_menu_option_set_write_flag() {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Write-FLAG' \
        'action_set_write_flag'
    return $?
}

function setup_settings_menu_option_set_action_header_flag() {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Action-Header-FLAG' \
        'action_set_action_header_flag'
    return $?
}

function setup_settings_menu_option_set_stock_symbol() {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Stock-Symbol' \
        'action_set_stock_symbol'
    return $?
}

function setup_settings_menu_option_set_base_currency() {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Base-Currency' \
        'action_set_base_currency'
    return $?
}

function setup_settings_menu_option_set_exchange_currency() {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Exchange-Currency' \
        'action_set_exchange_currency'
    return $?
}

function setup_settings_menu_option_set_watch_interval() {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Watch-Interval' \
        'action_set_watch_interval'
    return $?
}

function setup_settings_menu_option_set_watch_anchor_file() {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Watch-Anchor-File' \
        'action_set_watch_anchor_file'
    return $?
}

function setup_settings_menu_option_set_period() {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Period' \
        'action_set_period'
    return $?
}

function setup_settings_menu_option_set_period_interval() {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Period-Interval' \
        'action_set_period_interval'
    return $?
}

function setup_settings_menu_option_set_period_start() {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Period-Start' \
        'action_set_period_start'
    return $?
}

function setup_settings_menu_option_set_period_end() {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Period-End' \
        'action_set_period_end'
    return $?
}

function setup_settings_menu_option_set_write_mode() {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Write-Mode' \
        'action_set_write_mode'
    return $?
}

function setup_settings_menu_option_set_out_file() {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Out-File' \
        'action_set_out_file'
    return $?
}

function setup_settings_menu_option_set_action_target() {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Action-Target' \
        'action_set_action_target'
    return $?
}

function setup_settings_menu_option_set_crypto_topx() {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Crypto-TopX' \
        'action_set_crypto_topx'
    return $?
}

function setup_settings_menu_option_setup_machine() {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Setup-Machine' \
        'action_setup_machine'
    return $?
}

function setup_settings_menu_option_update_bot_conf_json() {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Update-Bot-Conf-JSON' \
        'action_update_bot_config_json_files'
    return $?
}

function setup_settings_menu_option_set_quantity() {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Quantity' \
        'action_set_quantity'
    return $?
}

function setup_settings_menu_option_set_silent_flag() {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Silence-FLAG' \
        'action_set_silence_flag'
    return $?
}

function setup_settings_menu_option_set_conf_file() {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Conf-File' \
        'action_set_config_file'
    return $?
}

function setup_settings_menu_option_set_conf_json() {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Conf-JSON' \
        'action_set_config_json_file'
    return $?
}

function setup_settings_menu_option_set_wpa_supplicant_file() {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-WPASupplicant-File' \
        'action_set_wpa_supplicant_file'
    return $?
}

function setup_settings_menu_option_set_bashrc_file() {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-BashRC-File' \
        'action_set_bashrc_file'
    return $?
}

function setup_settings_menu_option_set_bashrc_template() {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-BashRC-Template' \
        'action_set_bashrc_template_file'
    return $?
}

function setup_settings_menu_option_set_bashaliases_file() {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-BashAliases-File' \
        'action_set_bashaliases_file'
    return $?
}

function setup_settings_menu_option_set_hostname_file() {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Hostname-File' \
        'action_set_hostname_file'
    return $?
}

function setup_settings_menu_option_set_hosts_file() {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Hosts-File' \
        'action_set_hosts_file'
    return $?
}

function setup_settings_menu_option_set_cron_file() {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Cron-File' \
        'action_set_cron_file'
    return $?
}

function setup_settings_menu_option_set_wifi_essid() {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Wifi-Essid' \
        'action_set_wifi_essid'
    return $?
}

function setup_settings_menu_option_set_wifi_pass() {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Wifi-Password' \
        'action_set_wifi_password'
    return $?
}

function setup_settings_menu_option_set_system_user() {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-System-User' \
        'action_set_system_user'
    return $?
}

function setup_settings_menu_option_set_system_password() {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-System-Password' \
        'action_set_system_password'
    return $?
}

function setup_settings_menu_option_set_system_permsissions() {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-System-Permissions' \
        'action_set_system_permissions'
    return $?
}

function setup_settings_menu_option_update_conf_json() {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Update-Conf-JSON' \
        'action_update_config_json_file'
    return $?
}

function setup_settings_menu_option_set_log_file () {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Log-File' \
        'action_set_log_file'
    return $?
}

function setup_settings_menu_option_set_log_lines () {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Log-Lines' \
        'action_set_log_lines'
    return $?
}

function setup_settings_menu_option_install_dependencies () {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Install-Dependencies' \
        'action_install_dependencies'
    return $?
}

function setup_settings_menu_option_back () {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Back' 'action_back'
    return $?
}

# MAIN MENU SETUP

function setup_main_menu_controller() {
    setup_main_menu_option_bot_ctrl
    setup_main_menu_option_analysis_ctrl
    setup_main_menu_option_log_viewer
    setup_main_menu_option_control_panel
    setup_main_menu_option_help
    setup_main_menu_option_back
    done_msg "(${CYAN}$MAIN_CONTROLLER_LABEL${RESET}) controller"\
        "option binding complete."
    return 0
}

function setup_main_menu_option_help() {
    setup_menu_controller_action_option \
        "$MAIN_CONTROLLER_LABEL"  "Help" "action_help"
    return $?
}

function setup_main_menu_option_bot_ctrl() {
    setup_menu_controller_menu_option \
        "$MAIN_CONTROLLER_LABEL"  "Trading-Bots" \
        "$BOT_CONTROLLER_LABEL"
    return $?
}

function setup_main_menu_option_analysis_ctrl() {
    setup_menu_controller_menu_option \
        "$MAIN_CONTROLLER_LABEL"  "Stock-Analysis" \
        "$ANALYSIS_CONTROLLER_LABEL"
    return $?
}

function setup_main_menu_option_log_viewer () {
    setup_menu_controller_menu_option \
        "$MAIN_CONTROLLER_LABEL"  "Log-Viewer" \
        "$LOGVIEWER_CONTROLLER_LABEL"
    return $?
}

function setup_main_menu_option_control_panel () {
    setup_menu_controller_menu_option \
        "$MAIN_CONTROLLER_LABEL"  "Control-Panel" \
        "$SETTINGS_CONTROLLER_LABEL"
    return $?
}

function setup_main_menu_option_back () {
    setup_menu_controller_action_option \
        "$MAIN_CONTROLLER_LABEL"  "Back" \
        'action_back'
    return $?
}


# CODE DUMP

