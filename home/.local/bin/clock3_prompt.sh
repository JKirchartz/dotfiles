#!/usr/bin/env bash
# $Author: giles $, $Date: 1999/06/06 02:12:34 $
# $Source: /home/giles/.bashprompt/bashthemes/RCS/clock3,v $ 
# $Revision: 1.1 $
#
# $Log: clock3,v $
# Revision 1.1  1999/06/06 02:12:34  giles
# Initial revision
#

#   This prompt requires a VGA font.  The prompt is anchored at the bottom
#   of the terminal, fills the width of the terminal, and draws a line up
#   the right side of the terminal to attach itself to a clock in the upper
#   right corner of the terminal.
#
#   revised 12/19/25 by jkirchartz to comply with shellcheck (but still not working as expected)
#   discovered that in ancient times I based my prompt on one of giles' and, well...
#   ended up making something completely different that works just as well (if not better)...
#   https://gilesorr.com/bashprompt/prompts/

function prompt_command {
    #   Calculate the width of the prompt:
    hostnam=$(echo -n "$HOSTNAME" | sed -e "s/[\.].*//")
    #   "whoami" and "pwd" include a trailing newline
    usernam=$(whoami)
    COLS=${COLUMNS:-$(tput cols)}
    newPWD="${PWD}"
    #   Add all the accessories below ...
    promptsize=$(echo -n "--(${usernam}@${hostnam})---(${PWD})-----" \
        | wc -c | tr -d " ")
    #   Figure out how much to add between user@host and PWD (or how much to
    #   remove from PWD)
    fillsize=${COLS}-${promptsize}
    fill=""
    #   Make the filler if prompt isn't as wide as the terminal:
    while [ "$fillsize" -gt "0" ] 
    do 
        fill="${fill}-"
        fillsize=${fillsize}-1
    done
    #   Right-truncate PWD if the prompt is going to be wider than the terminal:
    if [ "$fillsize" -lt "0" ]
    then
        cutt=3-${fillsize}
        newPWD="...$(echo -n "$PWD" | sed -e "s/\(^.\{$cutt\}\)\(.*\)/\2/")"
    fi
    #
    #   Create the clock and the bar that runs up the right side of the term
    #
    local LIGHT_BLUE="\033[1;34m"
    local     YELLOW="\033[1;33m"
    #   Position the cursor to print the clock:
    echo -en "\033[2;$((COLS-9))H"
    echo -en "$LIGHT_BLUE($YELLOW$(date +%H%M)$LIGHT_BLUE)\304$YELLOW\304\304\277"
    local i=${LINES}
    echo -en "\033[2;${COLS}H"
    #   Print vertical dashes down the side of the terminal:
    while [ $i -ge 4 ]
    do
        echo -en "\033[$((i-1));${COLS}H\263"
        i=$i-1
    done

    prompt_line=${LINES}-1
    #   This is needed because doing \${LINES} inside a Bash mathematical
    #   expression (ie. $(())) doesn't seem to work.
}

PROMPT_COMMAND=prompt_command

function clock3 {
    local LIGHT_BLUE="\[\033[1;34m\]"
    local     YELLOW="\[\033[1;33m\]"
    local      WHITE="\[\033[1;37m\]"
    local LIGHT_GRAY="\[\033[0;37m\]"
    local  NO_COLOUR="\[\033[0m\]"

    case $TERM in
        xterm*)
            TITLEBAR='\[\033]0;\u@\h:\w\007\]'
            ;;
        *)
            TITLEBAR=""
            ;;
    esac

    PS1="$TITLEBAR\
        \[\033[\${prompt_line};0H\]
    $YELLOW\332$LIGHT_BLUE\304(\
        $YELLOW\${usernam}$LIGHT_BLUE@$YELLOW\${hostnam}\
        ${LIGHT_BLUE})\304${YELLOW}\304\${fill}${LIGHT_BLUE}\304(\
        $YELLOW\${newPWD}\
        $LIGHT_BLUE)\304$YELLOW\304\304\304\331\
        \n\
        $YELLOW\300$LIGHT_BLUE\304(\
        $YELLOW\$(date \"+%a,%d %b %y\")\
        $LIGHT_BLUE:$WHITE\$$LIGHT_BLUE)\304\
        $YELLOW\304\
        $LIGHT_GRAY " 

    PS2="$LIGHT_BLUE\304$YELLOW\304$YELLOW\304$NO_COLOUR "

}


