#!/bin/bash

MENU=${MENU:-mesa-dmenu}

declare -A SINK_BY_LABEL
LABELS=()

while IFS=$'\t' read -r ID _; do
    [ -z "$ID" ] && continue

    PROPS=$(wpctl inspect "$ID")
    LABEL=$(sed -n 's/^[ *]*node\.nick = "\(.*\)"$/\1/p' <<< "$PROPS")
    [ -z "$LABEL" ] && LABEL=$(sed -n 's/^[ *]*node\.description = "\(.*\)"$/\1/p' <<< "$PROPS")
    [ -z "$LABEL" ] && LABEL="Sink $ID"

    # labels are the key back to the id, so they have to stay unique
    while [ -n "${SINK_BY_LABEL[$LABEL]+set}" ]; do
        LABEL="$LABEL ($ID)"
    done

    SINK_BY_LABEL[$LABEL]=$ID
    LABELS+=("$LABEL")
done < <(wpctl list audio sinks)

if [ ${#LABELS[@]} -eq 0 ]; then
    echo "No audio sinks found" >&2
    exit 1
fi

CHOICE=$(printf '%s\n' "${LABELS[@]}" | "$MENU" | tr -d '\0\r')

[ -z "$CHOICE" ] && exit 0

ID=${SINK_BY_LABEL[$CHOICE]}

if [ -z "$ID" ]; then
    echo "Unknown sink: $CHOICE" >&2
    exit 1
fi

wpctl set-default "$ID"
