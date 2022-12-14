#!/bin/bash
#
# Regards, the Alveare Solutions #!/Society -x
#
# GENERAL

# TODO - Under construction, building...
function process_cli_args() {
    local ARGUMENTS=( $@ )
    local FAILURE_COUNT=0
    if [ ${#ARGUMENTS[@]} -eq 0 ]; then
        return 1
    fi
    for opt in "${ARGUMENTS[@]}"; do
        case "$opt" in
            -h|--help)
                display_usage
                exit 0
                ;;
            -S|--setup)
                cli_action_setup
                if [ $? -ne 0 ]; then
                    local FAILURE_COUNT=$((FAILURE_COUNT + 1))
                fi
                ;;
            *)
                echo "[ WARNING ]: Invalid CLI arg! (${opt})"
                ;;
        esac
    done
    return $FAILURE_COUNT
}

# TODO - Move to machine dialogue
function confirm_loaded_action_values_with_user() {
    local ACTION_VALUES=( $@ )
    echo; info_msg "Loaded action values -
    "
    while :; do
        display_ng_settings ${ACTION_VALUES[@]}; echo
        fetch_ultimatum_from_user 'Change action values? [Y/N]'
        if [ $? -eq 0 ]; then
            update_action_values ${ACTION_VALUES[@]}
            local EXIT_CODE=$?
            if [ $EXIT_CODE -eq 1 ]; then
                warning_msg "Something went wrong! Could not update action values!"
                return 1
            fi
            continue
        fi
        break
    done
    fetch_ultimatum_from_user 'Rock n Roll? [Y/N]'
    if [ $? -ne 0 ]; then
        echo; info_msg "Aborting action."
        return 2
    fi
    return 0
}

# TODO - Refactor and move to machine dialogue
function update_action_values() {
    local ACTION_VALUE_LABELS=( $@ )
    local FAILURES=0
    while :; do
        echo; info_msg "Select setting to modify -
        "
        ACTION_LABEL=`fetch_selection_from_user 'Setting' ${ACTION_VALUE_LABELS[@]}`
        if [[ -z "$ACTION_LABEL" ]]; then
            info_msg "Aborting action.
            "
            break
        fi
        case "$ACTION_LABEL" in
            'ticker-symbol')
                action_set_stock_symbol; break
                ;;
            'watch-interval')
                action_set_watch_interval; break
                ;;
            'watch-flag')
                action_set_watch_flag; break
                ;;
            'watch-anchor-file')
                action_set_watch_anchor_file; break
                ;;
            'period')
                action_set_period; break
                ;;
            'period-interval')
                action_set_period_interval; break
                ;;
            'period-start')
                action_set_period_start; break
                ;;
            'period-end')
                action_set_period_end; break
                ;;
            'action-header')
                action_set_action_header_flag; break
                ;;
            'write-flag')
                action_set_write_flag; break
                ;;
            'write-mode')
                action_set_write_mode; break
                ;;
            'out-file')
                action_set_out_file; break
                ;;
            'base-currency')
                action_set_base_currency; break
                ;;
            'exchange-currency')
                action_set_exchange_currency; break
                ;;
            'crypto-topx')
                action_set_crypto_topx; break
                ;;
            'quantity')
                action_set_quantity; break
                ;;
            'conf-json-file')
                action_set_config_json_file; break
                ;;
            'log-file')
                action_set_log_file; break
                ;;
            'action')
                action_set_cargo_action; break
                ;;
            'action-target')
                action_set_cargo_action_target; break
                ;;
            "ar-conf-file")
                action_set_ar_conf_file; continue
                ;;
            "ar-profit-baby")
                action_set_ar_profit_baby; continue
                ;;
            "ar-watchdog-pid-file")
                action_set_ar_watchdog_pid_file; continue
                ;;
            "ar-watchdog-anchor-file")
                action_set_ar_watchdog_anchor_file; continue
                ;;
            "ar-api-key")
                action_set_ar_api_key; continue
                ;;
            "ar-api-secret")
                action_set_ar_api_secret; continue
                ;;
            "ar-taapi-key")
                action_set_ar_taapi_key; continue
                ;;
            "ar-api-url")
                action_set_ar_api_url; continue
                ;;
            "ar-taapi-url")
                action_set_ar_taapi_url; continue
                ;;
            "ar-max-trades")
                action_set_ar_max_trades; continue
                ;;
            "ar-trading-account-type")
                action_set_ar_trading_account_type; continue
                ;;
            "ar-trading-order-type")
                action_set_ar_trading_order_type; continue
                ;;
            "ar-order-time-in-force")
                action_set_ar_order_time_in_force; continue
                ;;
            "ar-order-response-type")
                action_set_ar_order_response_type; continue
                ;;
            "ar-order-recv-window")
                action_set_ar_order_recv_window; continue
                ;;
            "ar-order-price")
                action_set_ar_order_price; continue
                ;;
            "ar-order-amount")
                action_set_ar_order_amount; continue
                ;;
            "ar-stop-loss")
                action_set_ar_stop_loss; continue
                ;;
            "ar-take-profit")
                action_set_ar_take_profit; continue
                ;;
            "ar-trailing-stop")
                action_set_ar_trailing_stop; continue
                ;;
            "ar-test")
                action_set_ar_test_flag; continue
                ;;
            "ar-debug")
                action_set_ar_debug_flag; continue
                ;;
            "ar-silence")
                action_set_ar_silence_flag; continue
                ;;
            "ar-analyze-risk")
                action_set_ar_analyze_risk_flag; continue
                ;;
            "ar-risk-tolerance")
                action_set_ar_risk_tolerance; continue
                ;;
            "ar-indicator-update-delay")
                action_set_ar_indicator_update_delay; continue
                ;;
            "ar-strategy")
                action_set_ar_strategy; continue
                ;;
            "ar-side")
                action_set_ar_side; continue
                ;;
            "ar-interval")
                action_set_ar_interval; continue
                ;;
            "ar-period")
                action_set_ar_period; continue
                ;;
            "ar-market-open")
                action_set_ar_market_open; continue
                ;;
            "ar-market-close")
                action_set_ar_market_close; continue
                ;;
            "ar-backtrack")
                action_set_ar_backtrack; continue
                ;;
            "ar-backtracks")
                action_set_ar_backtracks; continue
                ;;
            "ar-stop-limit")
                action_set_ar_stop_limit; continue
                ;;
            "ar-stop-price")
                action_set_ar_stop_price; continue
                ;;
            "ar-stop-limit-price")
                action_set_ar_stop_limit_price; continue
                ;;
            "ar-stop-limit-time-in-force")
                action_set_ar_stop_limit_time_in_force; continue
                ;;
            'ar-rsi-top')
                action_set_ar_rsi_top; continue
                ;;
            'ar-rsi-bottom')
                action_set_ar_rsi_bottom; continue
               ;;
            'ar-macd-fast-period')
                action_set_ar_macd_fast_period; continue
               ;;
            'ar-macd-slow-period')
                action_set_ar_macd_slow_period; continue
               ;;
            'ar-macd-signal-period')
                action_set_ar_macd_signal_period; continue
               ;;
            'ar-price-movement')
                action_set_ar_price_movement; continue
               ;;
            'ar-volume-movement')
                action_set_ar_volume_movement; continue
                ;;
            'ar-report-id-length')
                action_set_ar_report_id_length; continue
                ;;
            'ar-report-id-characters')
                action_set_ar_report_id_characters; continue
                ;;
            'ar-report-location')
                action_set_ar_report_location; continue
                ;;
            *)
                error_msg "Invalid action value label! (${RED}${action_label}${RESET})"
                local FAILURES=$((FAILURES + 1))
                ;;
        esac
    done
    local FAILURES=$((FAILURES + $?))
    return $FAILURES
}
