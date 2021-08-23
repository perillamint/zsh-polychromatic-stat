# Color
POLYCHROMATIC_RED='#ff0000'
POLYCHROMATIC_GREEN='#00ff00'
POLYCHROMATIC_BLUE='#0000ff'
POLYCHROMATIC_WHITE='#ffffff'


polychromatic_preexec() {
    if [ "$POLYCHROMATIC_STATUSCODE" != "" ]; then
        polychromatic-cli -o spectrum
    fi
}

polychromatic_precmd() {
    local exit_status="${1:-$(print -P %?)}";
    if [ "$POLYCHROMATIC_STATUSCODE" != "" ]; then
        case "$exit_status" in
            0)
            polychromatic-cli -o breath -p single -c "$POLYCHROMATIC_GREEN"
            ;;
            *)
            polychromatic-cli -o breath -p single -c "$POLYCHROMATIC_RED"
            ;;
        esac
    fi
}

precmd_functions+=(polychromatic_precmd)
preexec_functions+=(polychromatic_preexec)
