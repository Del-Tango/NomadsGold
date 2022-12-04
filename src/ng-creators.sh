#!/bin/bash
#
# Regards, the Alveare Solutions #!/Society -x
#
# CREATORS

function create_project_menu_controllers () {
    create_main_menu_controller
    create_ar_bot_ctrl_menu_controller
    create_bot_ctrl_menu_controller
    create_analysis_ctrl_menu_controller
    create_log_viewer_menu_cotroller
    create_settings_menu_controller
    done_msg "${BLUE}$SCRIPT_NAME${RESET} controller construction complete."
    return 0
}

function create_ar_bot_ctrl_menu_controller() {
    create_menu_controller "$AR_CONTROLLER_LABEL" \
        "${CYAN}$AR_CONTROLLER_DESCRIPTION${RESET}" \
        "$AR_CONTROLLER_OPTIONS"
    info_msg "Setting ${CYAN}$AR_CONTROLLER_LABEL${RESET} extented"\
        "banner function ${MAGENTA}display_ar_bot_ctrl_settings${RESET}..."
    set_menu_controller_extended_banner "$AR_CONTROLLER_LABEL" \
        'display_ar_bot_ctrl_settings'
    return $?
}

function create_bot_ctrl_menu_controller () {
    create_menu_controller "$BOT_CONTROLLER_LABEL" \
        "${CYAN}$BOT_CONTROLLER_DESCRIPTION${RESET}" \
        "$BOT_CONTROLLER_OPTIONS"
    info_msg "Setting ${CYAN}$BOT_CONTROLLER_LABEL${RESET} extented"\
        "banner function ${MAGENTA}display_server_ctrl_settings${RESET}..."
    set_menu_controller_extended_banner "$BOT_CONTROLLER_LABEL" \
        'display_bot_ctrl_settings'
    return $?
}

function create_analysis_ctrl_menu_controller () {
    create_menu_controller "$ANALYSIS_CONTROLLER_LABEL" \
        "${CYAN}$ANALYSIS_CONTROLLER_DESCRIPTION${RESET}" \
        "$ANALYSIS_CONTROLLER_OPTIONS"
    info_msg "Setting ${CYAN}$ANALYSIS_CONTROLLER_LABEL${RESET} extented"\
        "banner function ${MAGENTA}display_manual_ctrl_settings${RESET}..."
    set_menu_controller_extended_banner "$ANALYSIS_CONTROLLER_LABEL" \
        'display_analysis_ctrl_settings'
    return $?
}

function create_main_menu_controller () {
    create_menu_controller "$MAIN_CONTROLLER_LABEL" \
        "${CYAN}$MAIN_CONTROLLER_DESCRIPTION${RESET}" "$MAIN_CONTROLLER_OPTIONS"
    info_msg "Setting ${CYAN}$MAIN_CONTROLLER_LABEL${RESET} extented"\
        "banner function ${MAGENTA}display_main_settings${RESET}..."
    set_menu_controller_extended_banner "$MAIN_CONTROLLER_LABEL" \
        'display_main_settings'
    return $?
}

function create_log_viewer_menu_cotroller () {
    create_menu_controller "$LOGVIEWER_CONTROLLER_LABEL" \
        "${CYAN}$LOGVIEWER_CONTROLLER_DESCRIPTION${RESET}" \
        "$LOGVIEWER_CONTROLLER_OPTIONS"
    return $?
}

function create_settings_menu_controller () {
    create_menu_controller "$SETTINGS_CONTROLLER_LABEL" \
        "${CYAN}$SETTINGS_CONTROLLER_DESCRIPTION${RESET}" \
        "$SETTINGS_CONTROLLER_OPTIONS"
    info_msg "Setting ${CYAN}$SETTINGS_CONTROLLER_LABEL${RESET} extented"\
        "banner function ${MAGENTA}display_project_settings${RESET}..."
    set_menu_controller_extended_banner "$SETTINGS_CONTROLLER_LABEL" \
        'display_project_settings'
    return 0
}

