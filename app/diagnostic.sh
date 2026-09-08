#!/usr/bin/env bash

# File: app/diagnostic.sh
# Exit Codes: 0 = Success, 1 = Runtime Failure, 2 = Invalid Command/Input

COMMAND="$1"
SHIFT_ARG="$2"

usage() {
    echo "Usage: diagnostic <command> [args]"
    echo ""
    echo "Commands:"
    echo "  system          Display useful Linux system information."
    echo "  disk            Display disk usage information."
    echo "  network <host>  Check connectivity to the supplied host."
    echo "  help            Display this help message."
}

case "$COMMAND" in
    system)
        echo "=== SYSTEM DIAGNOSTIC ==="
        echo "Hostname:     $(hostname)"
        echo "Kernel:       $(uname -r)"
        echo "OS:           $(uname -s)"
        echo "Uptime:       $(uptime -p 2>/dev/null || uptime 2>/dev/null || echo "N/A")"
        echo "Working Dir:  $(pwd)"
        ;;
    disk)
        echo "=== DISK DIAGNOSTIC ==="
        df -h /
        ;;
    network)
        if [ -z "$SHIFT_ARG" ]; then
            echo "Error: Network command requires a target host."
            usage
            exit 2
        fi
        echo "=== NETWORK DIAGNOSTIC ==="
        echo "Target: $SHIFT_ARG"
        if ping -c 2 "$SHIFT_ARG" >/dev/null 2>&1; then
            echo "Status: REACHABLE"
            exit 0
        else
            echo "Status: UNREACHABLE"
            exit 1
        fi
        ;;
    help|"")
        usage
        exit 0
        ;;
    *)
        echo "Error: Unknown command '$COMMAND'"
        usage
        exit 2
        ;;
esac
