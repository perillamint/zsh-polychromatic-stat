# Color
POLYCHROMATIC_RED='#ff0000'
POLYCHROMATIC_GREEN='#00ff00'
POLYCHROMATIC_BLUE='#0000ff'
POLYCHROMATIC_WHITE='#ffffff'

_silent_polychromatic() {
    (polychromatic-cli "${@:1}" &)
}

_polychromatic_preexec() {
    if [ "$ENABLE_POLYCHROMATIC_STATUSCODE" != "true" ]; then
        return 0
    fi
    _silent_polychromatic -o spectrum
}

_polychromatic_precmd() {
    local exit_status="${1:-$(print -P %?)}";
    if [ "$ENABLE_POLYCHROMATIC_STATUSCODE" != "true" ]; then
        return 0
    fi
    case "$exit_status" in
        0)
        _silent_polychromatic -o breath -p single -c "$POLYCHROMATIC_GREEN"
        ;;
        *)
        _silent_polychromatic -o breath -p single -c "$POLYCHROMATIC_RED"
        ;;
    esac
}

precmd_functions+=(_polychromatic_precmd)
preexec_functions+=(_polychromatic_preexec)
