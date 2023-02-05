#!/bin/bash
#
# This is free and unencumbered software released into the public domain.
#
# Anyone is free to copy, modify, publish, use, compile, sell, or
# distribute this software, either in source code form or as a compiled
# binary, for any purpose, commercial or non-commercial, and by any
# means.
#
# In jurisdictions that recognize copyright laws, the author or authors
# of this software dedicate any and all copyright interest in the
# software to the public domain. We make this dedication for the benefit
# of the public at large and to the detriment of our heirs and
# successors. We intend this dedication to be an overt act of
# relinquishment in perpetuity of all present and future rights to this
# software under copyright law.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#
# For more information, please refer to <http://unlicense.org/>

WAYVNCCTL=${WAYVNCCTL:-wayvncctl}
SWAYMSG=${SWAYMSG:-swaymsg}

SWAY_HAS_UNPLUG=false
IFS=" .-" read -r _ _ SWAYMAJOR SWAYMINOR _ < <($SWAYMSG -v)
if [[ $SWAYMAJOR -ge 1 && $SWAYMINOR -ge 8 ]]; then
    echo "Detected sway version 1.8 or later: Enabling virtual output device mode"
    SWAY_HAS_UNPLUG=true
else
    echo "Detected sway version 1.7 or earlier: Not enabling virtual output device mode"
fi

find_output_matching() {
    local pattern=$1
    $WAYVNCCTL -j output-list | jq -r ".[].name | match(\"$pattern\").string"
}

wait_for_output_matching() {
    local pattern=$1
    local output
    output=$(find_output_matching "$pattern")
    while [[ -z $output ]]; do
        sleep 0.5
        output=$(find_output_matching "$pattern")
    done
    echo "$output"
}

OUTPUTS_TO_RECONNECT=()
HEADLESS=
restore_outputs() {
    [[ ${#OUTPUTS_TO_RECONNECT[@]} -ge 1 ]] || return
    echo "Restoring original output state"
    for output in "${OUTPUTS_TO_RECONNECT[@]}"; do
        echo "Re-enabling output $output"
        $SWAYMSG output "$output" enable
    done
    if [[ $SWAY_HAS_UNPLUG == true && $HEADLESS ]]; then
        local firstOutput=${OUTPUTS_TO_RECONNECT[0]}
        echo "Switching wayvnc back to physical output $firstOutput"
        wait_for_output_matching "$firstOutput" >/dev/null
        $WAYVNCCTL output-set "$firstOutput"
        echo "Removing virtual output $HEADLESS"
        $SWAYMSG output "$HEADLESS" unplug
    fi
    OUTPUTS_TO_RECONNECT=()
    HEADLESS=
}
trap restore_outputs EXIT

collapse_outputs() {
    if [[ $SWAY_HAS_UNPLUG == true ]]; then
        local preexisting="$(find_output_matching 'HEADLESS-\\d+')"
        if [[ $preexisting ]]; then
            echo "Switching to preexisting virtual output $preexisting"
            $WAYVNCCTL output-set "$preexisting"
        else
            echo "Creating a virtual display"
            $SWAYMSG create_output
            echo "Waiting for virtusl output to be created..."
            HEADLESS=$(wait_for_output_matching 'HEADLESS-\\d+')
            echo "Switching to virtual output $HEADLESS"
            $WAYVNCCTL output-set "$HEADLESS"
        fi
    fi
    for output in $($WAYVNCCTL -j output-list | jq -r '.[] | select(.captured==false).name'); do
        echo "Disabling extra output $output"
        $SWAYMSG output "$output" disable
        OUTPUTS_TO_RECONNECT+=("$output")
    done
}

connection_count_now() {
    local count=$1
    if [[ $count == 1 ]]; then
        collapse_outputs
    elif [[ $count == 0 ]]; then
        restore_outputs
    fi
}

while IFS= read -r EVT; do
    case "$(jq -r '.method' <<<"$EVT")" in
        client-*onnected)
            count=$(jq -r '.params.connection_count' <<<"$EVT")
            connection_count_now "$count"
            ;;
        wayvnc-shutdown)
            echo "wayvncctl is no longer running"
            connection_count_now 0
            ;;
        wayvnc-startup)
            echo "Ready to receive wayvnc events"
            ;;
    esac
done < <("$WAYVNCCTL" --wait --reconnect --json event-receive)
