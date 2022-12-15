#!/bin/bash
#
# Regards, the Alveare Solutions society.
#
# SETTERS

function set_write_mode() {
    local MODE="$1"
    MD_DEFAULT['write-mode']=${MODE:0:1}
    return 0
}

function set_ar_report_location() {
    local DIR_PATH=$1
    MD_DEFAULT['ar-report-location']=$DIR_PATH
    return 0
}

function set_ar_report_id_characters() {
    local CHARACTERS="$1"
    MD_DEFAULT['ar-report-id-characters']=$CHARACTERS
    return 0
}

function set_ar_report_id_length() {
    local LENGTH=$1
    MD_DEFAULT['ar-report-id-length']=$LENGTH
    return 0
}

function set_ar_volume_movement() {
    local PERCENT=$1
    MD_DEFAULT['ar-volume-movement']=$PERCENT
    return 0
}

function set_ar_price_movement() {
    local PERCENT=$1
    MD_DEFAULT['ar-price-movement']=$PERCENT
    return 0
}

function set_ar_macd_signal_period_movement() {
    local PERIOD=$1
    MD_DEFAULT['ar-macd-signal-period']=$PERIOD
    return 0
}

function set_ar_strategy() {
    local STRATEGY="$1"
    MD_DEFAULT['ar-strategy']=$STRATEGY
    return 0
}

function set_ar_macd_slow_period() {
    local PERIOD=$1
    MD_DEFAULT['ar-macd-slow-period']=$PERIOD
    return 0
}

function set_ar_macd_fast_period() {
    local PERIOD=$1
    MD_DEFAULT['ar-macd-fast-period']=$PERIOD
    return 0
}

function set_ar_rsi_top() {
    local HIGH_VALUE=$1
    MD_DEFAULT['ar-rsi-top']=$HIGH_VALUE
    return 0
}

function set_ar_rsi_bottom() {
    local LOW_VALUE=$1
    MD_DEFAULT['ar-rsi-bottom']=$LOW_VALUE
    return 0
}

function set_ar_backtracks() {
    local CANDLES=$1
    MD_DEFAULT['ar-backtracks']=$CANDLES
    return 0
}

function set_ar_backtrack() {
    local CANDLES=$1
    MD_DEFAULT['ar-backtrack']=$CANDLES
    return 0
}

function set_ar_period() {
    local PERIOD="$1"
    MD_DEFAULT['ar-period']=$PERIOD
    return 0
}

function set_ar_indicator_update_delay() {
    local SECONDS=$1
    MD_DEFAULT['ar-indicator-update-delay']=$SECONDS
    return 0
}

function set_ar_take_profit() {
    local PERCENT=$1
    MD_DEFAULT['ar-take-profit']=$PERCENT
    return 0
}

function set_ar_stop_loss() {
    local PERCENT=$1
    MD_DEFAULT['ar-stop-loss']=$PERCENT
    return 0
}

function set_ar_order_amount() {
    local AMOUNT=$1
    MD_DEFAULT['ar-order-amount']=$AMOUNT
    return 0
}

function set_ar_max_trades() {
    local MAX_TRADES=$1
    MD_DEFAULT['ar-max-trades']=$MAX_TRADES
    return 0
}

function set_ar_debug_flag() {
    local FLAG="$1"
    MD_DEFAULT['ar-debug']=$FLAG
    return 0
}

function set_ar_test_flag() {
    local FLAG="$1"
    MD_DEFAULT['ar-test']=$FLAG
    return 0
}

function set_ar_silence_flag() {
    local FLAG="$1"
    MD_DEFAULT['ar-silence']=$FLAG
    return 0
}

function set_ar_analyze_risk_flag() {
    local FLAG="$1"
    MD_DEFAULT['ar-analyze-risk']=$FLAG
    return 0
}

function set_ar_market_close() {
    local HOUR="$1"
    MD_DEFAULT['ar-market-close']=$HOUR
    return 0
}

function set_ar_market_open() {
    local HOUR="$1"
    MD_DEFAULT['ar-market-open']=$HOUR
    return 0
}

function set_ar_interval() {
    local INTERVAL="$1"
    MD_DEFAULT['ar-interval']=$INTERVAL
    return 0
}

function set_ar_side() {
    local SIDE="$1"
    MD_DEFAULT['ar-side']=$SIDE
    return 0
}

function set_ar_risk_tolerance() {
    local LEVEL="$1"
    MD_DEFAULT['ar-risk-tolerance']=$LEVEL
    return 0
}

function set_ar_taapi_url() {
    local URL="$1"
    MD_DEFAULT['ar-taapi-url']=$URL
    return 0
}

function set_ar_api_url() {
    local URL="$1"
    MD_DEFAULT['ar-api-url']=$URL
    return 0
}

function set_ar_taapi_key() {
    local KEY="$1"
    MD_DEFAULT['ar-taapi-key']=$KEY
    return 0
}

function set_ar_secret_key() {
    local KEY="$1"
    MD_DEFAULT['ar-api-secret']=$KEY
    return 0
}

function set_ar_api_key() {
    local KEY="$1"
    MD_DEFAULT['ar-api-key']=$KEY
    return 0
}

function set_ar_watchdog_anchor_file() {
    local FILE_PATH="$1"
    MD_DEFAULT['ar-watchdog-anchor-file']=$FILE_PATH
    return 0
}

function set_ar_watchdog_pid_file() {
    local FILE_PATH="$1"
    MD_DEFAULT['ar-watchdog-pid-file']=$FILE_PATH
    return 0
}

function set_ar_profit_baby() {
    local PERCENTAGE=$1
    MD_DEFAULT['ar-profit-baby']=$PERCENTAGE
    return 0
}

function set_ar_conf_file() {
    local FILE_PATH="$1"
    MD_DEFAULT['ar-conf-file']=$FILE_PATH
    return 0
}

function set_action() {
    local ACTION="$1"
    MD_DEFAULT['action']=$ACTION
    return 0
}

function set_action_target() {
    local TARGET="$1"
    MD_DEFAULT['action-target']=$TARGET
    return 0
}

function set_period_end_date() {
    local DATE="$1"
    MD_DEFAULT['period-end']=$DATE
    return 0
}

function set_period_start_date() {
    local DATE="$1"
    MD_DEFAULT['period-start']=$DATE
    return 0
}

function set_period_interval() {
    local INTERVAL="$1"
    MD_DEFAULT['period-interval']=$INTERVAL
    return 0
}

function set_period() {
    local PERIOD="$1"
    MD_DEFAULT['period']=$PERIOD
    return 0
}

function set_watch_anchor_file() {
    local FILE_PATH="$1"
    MD_DEFAULT['watch-anchor-file']=$FILE_PATH
    return 0
}

function set_watch_interval() {
    local INTERVAL="$1"
    MD_DEFAULT['watch-interval']=$INTERVAL
    return 0
}

function set_exchange_currency() {
    local CURRENCY="$1"
    MD_DEFAULT['exchange-currency']=$CURRENCY
    return 0
}

function set_base_currency() {
    local CURRENCY="$1"
    MD_DEFAULT['base-currency']=$CURRENCY
    return 0
}

function set_stock_symbol() {
    local SYMBOL="$1"
    MD_DEFAULT['ticker-symbol']=$SYMBOL
    return 0
}

function set_quantity() {
    local QUANTITY="$1"
    MD_DEFAULT['quantity']=$QUANTITY
    return 0
}

function set_out_file() {
    local FILE_PATH="$1"
    MD_DEFAULT['out-file']=$FILE_PATH
    return 0
}

function set_crypto_topx() {
    local CRYPTO_TOPX="$1"
    MD_DEFAULT['crypto-topx']=$CRYPTO_TOPX
    return 0
}

function set_action_header_flag() {
    local FLAG="$1"
    MD_DEFAULT['action-header']="$FLAG"
    return 0
}

function set_write_flag() {
    local FLAG="$1"
    MD_DEFAULT['write']="$FLAG"
    return 0
}

function set_watch_flag() {
    local FLAG="$1"
    MD_DEFAULT['watch']="$FLAG"
    return 0
}

function set_wifi_password() {
    local WIFI_PASS="$1"
    MD_DEFAULT['wifi-pass']="$WIFI_PASS"
    return 0
}

function set_wifi_essid() {
    local WIFI_ESSID="$1"
    MD_DEFAULT['wifi-essid']="$WIFI_ESSID"
    return 0
}

function set_system_user() {
    local USER_NAME="$1"
    MD_DEFAULT['system-user']="$USER_NAME"
    return 0
}

function set_system_password() {
    local SYS_PASS="$1"
    MD_DEFAULT['system-pass']="$SYS_PASS"
    return 0
}

function set_user_file_permissions() {
    local OCTAL_PERMS=$1
    MD_DEFAULT['system-perms']=$OCTAL_PERMS
    return 0
}

function set_silence_flag() {
    local FLAG="$1"
    MD_DEFAULT['silence']="$FLAG"
    return 0
}

function set_user_cron_file() {
    local FILE_PATH="$1"
    MD_DEFAULT['cron-file']="$FILE_PATH"
    return 0
}

function set_system_hosts_file() {
    local FILE_PATH="$1"
    MD_DEFAULT['hosts-file']="$FILE_PATH"
    return 0
}

function set_system_hostname_file() {
    local FILE_PATH="$1"
    MD_DEFAULT['hostname-file']="$FILE_PATH"
    return 0
}

function set_user_bash_aliases_file() {
    local FILE_PATH="$1"
    MD_DEFAULT['bashaliases-files']="$FILE_PATH"
    return 0
}

function set_user_bashrc_file() {
    local FILE_PATH="$1"
    MD_DEFAULT['bashrc-file']="$FILE_PATH"
    return 0
}

function set_user_bashrc_template_file() {
    local FILE_PATH="$1"
    MD_DEFAULT['bashrc-template']="$FILE_PATH"
    return 0
}

function set_system_wpa_supplicant_file() {
    local FILE_PATH="$1"
    MD_DEFAULT['wpa-file']="$FILE_PATH"
    return 0
}

function set_json_config_file() {
    local FILE_PATH="$1"
    MD_DEFAULT['conf-json-file']="$FILE_PATH"
    return 0
}

function set_config_file() {
    local FILE_PATH="$1"
    MD_DEFAULT['conf-file']="$FILE_PATH"
    return 0
}

# CODE DUMP

