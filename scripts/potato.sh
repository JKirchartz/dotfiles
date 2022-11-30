#! /bin/bash

ORC=0;
DESTINY=0;
POTATOES=0;
ORC_COST=1;

function yes_or_no {
    while true; do
        read -rp "$* [y/n]: " yn
        case $yn in
            [Yy]*) return 0  ;;
            [Nn]*) return  1 ;;
        esac
    done
}

function checkscore {
    GAMEOVER=0;
    if [[ $DESTINY -gt 9 ]]; then
        echo "An interfering bard or wizard turns up at your doorstep with a quest,";
        echo "you are whisked away against your will on an adventure.";
        GAMEOVER=1;
    fi
    if [[ $POTATOES -gt 9 ]]; then
        echo "You have enough potatoes that you can go underground and not return";
        echo "to the surface until the danger is past. You nestle down into your";
        echo "burrow and enjoy your well-earned rest."
        GAMEOVER=1;
    fi;
    if [[ $ORC -gt 9 ]]; then
        echo "Orcs finally find your potato farm.";
         echo "Alas, orcs are not so interested in potatoes as they are in eating you.";
         echo "You end up in a cookpot."
        GAMEOVER=1;
    fi

    if [[ $GAMEOVER -gt 0 ]]; then
        echo "---------";
        echo "game over";

        if ( yes_or_no "Play Again?" ); then
            reset;
        else
            echo "Bye!";
            exit 0;
        fi
    fi;
}

function garden {
    echo "In the Garden...";
    DICE=$(( RANDOM % 6 ));
    case $DICE in
        0)
            echo "You happily root about all day in your garden";
            (( POTATOES++ ));
            ;;
        1)
            echo "You narrowly avoid a visitor by hiding in a potato sack.";
            (( DESTINY++ ));
            (( POTATOES++ ));
            ;;
        2)
            echo "A hooded stranger lingers outside your farm";
            (( DESTINY++ ));
            (( ORC++ ));
            ;;
        3)
            echo "Your field is ravaged in the night by unseen enemies";
            (( POTATOES-- ));
            (( ORC++ ));
            ;;
        4)
            echo "You trade potatoes for other delicious foodstuffs.";
            (( POTATOES-- ));
            ;;
        5)
            echo "You burrow into a bumper crop of potatoes. Do you cry with joy? Possibly.";
            (( POTATOES+=2 ));
            ;;
    esac
}

function knock {
    echo "A Knock at the Door...";
    DICE=$(( RANDOM % 6 ));
    case $DICE in
        0)
            echo "A distant cousin. They are after your potatoes. They may snitch on you.";
            (( ORC++ ));
            ;;
        1)
            echo "A dwarven stranger. You refuse them entry. Ghastly creatures.";
            (( DESTINY++ ));
            ;;
        2)
            echo "A wizard strolls by. You pointedly draw the curtains.";
            (( DESTINY++ ));
            (( ORC++ ));
            ;;
        3)
            echo "There are rumors of war in the reaches. You eat some potatoes.";
            (( POTATOES-- ));
            (( ORC+=2 ));
            ;;
        4)
            echo "It's an elf. They are not serious people.";
            (( DESTINY++ ));
            ;;
        5)
            echo "It's a sack of potatoes from a generous neighbour. You really must remember to pay them a visit one of these years.";
            (( POTATOES+=2 ))
            ;;
    esac
}

function escalate {
    echo "The world becomes a darker more dangerous place.";
    echo "From not on, removing ORC costs an additional POTATO";
    echo "(this is cumulative)";
    (( ORC_COST++ ));
}

function throw {
    if [[ $POTATOES -ge $ORC_COST ]]; then
        if [[ $ORC -gt 0 ]]; then
            echo "You hurl a potato back in the garden, there is now one less orc.";
            (( ORC-- ));
            (( POTATOES=POTATOES-ORC_COST ));
        else
            echo "No orcs to throw potatoes at.";
        fi
    else
        echo "You can't afford to throw these potatoes";
    fi
}

function roll {
    DICE=$(( RANDOM % 6 ));
    case $DICE in
        0|1) garden;;
        2|3) knock;;
        4|5) escalate;;
     esac
     checkscore;
}

function parser {
  shopt -s nocasematch
  case "$*" in
    exit) exit 0;;
    get*) echo "Ye cannot $*";;
    throw*) throw;;
    *) roll;;
  esac

  echo "---------";
  echo "     score:";
  echo "     Destiny: $DESTINY, Potatoes: $POTATOES, Orcs: $ORC";
}

function reset {
    echo "";
    echo "POTATO";
    echo "";
    echo "You are a halfling, just trying to exist";
    echo "Meanwhile, the dark lord rampages across the world";
    echo "you do not care about this, you are trying to farm potatoes";
    echo "because what could a halfling possibly do about it anyway";

    ORC=0;
    DESTINY=0;
    POTATOES=0;
    ORC_COST=1;
    # fake a shell
    while read -rp "potato $>" i; do parser "$i"; done
}

reset

