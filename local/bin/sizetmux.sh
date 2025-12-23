#!/bin/bash

pw0=85
[[ "$1" =~ ^[0-9]+$ ]] && pw0="$1"

# This could be done nicer, but, anyhow: getting current width of pane 0
pw0_cur_w=$(tmux list-panes | awk -F"[ x:\\\[\\\]]+" '/^0:/{print $2}')

echo $pw0_cur_w

((w = pw0_cur_w - pw0))


if [[ "$w" -ge 0 ]]; then
    dir="L"
    echo "$w less"
else
    dir="R"
    ((w *= -1))
    echo "$w more"
fi

echo $pane

[[ "$w" -gt "0" ]] && tmux resize-pane -"$dir" -t 0 "$w"
