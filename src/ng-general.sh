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
    return 0
}

# TODO - Refactor and move to machine dialogue
function update_action_values() {
    local ACTION_VALUE_LABELS=( $@ )
    local FAILURES=0
    for action_label in ${ACTION_VALUE_LABELS[@]}; do
        case "$action_label" in
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
            *)
                error_msg "Invalid action value label! (${RED}${action_label}${RESET})"
                local FAILURES=$((FAILURES + 1))
                ;;
        esac
    done
    local FAILURES=$((FAILURES + $?))
    return $FAILURES
}
