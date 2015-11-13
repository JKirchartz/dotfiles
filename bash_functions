# Function to update a shell inside tmux with new environment variables (really
# useful for switching between ssh and local) function update-environment
# stolen from https://github.com/xanderman/dotfiles/blob/master/.bashrc#L105
function update-environment {
  local v
  while read v; do
    if [[ $v == -* ]]; then
      unset ${v/#-/}
    else
      # Surround value with quotes
      v=${v/=/=\"}
      v=${v/%/\"}
      eval export $v
    fi
  done < <(tmux show-environment)
}


 # ps + grep (via egghead on freenode#web)
function pgrep(){ ps -ax | grep $1 | grep -v "grep"; }
# why not history
function hgrep(){ history | grep $1; }


# get the word of the day
function wotd {
    local DICTIONARY=/usr/share/dict/words
    if [ -f $DICTIONARY ]; then
      # hat-tip to flukiluke@blinkenshell for this hash:
      local n=$(echo $(date +%D|md5sum) $(wc -l ${DICTIONARY}) |  awk '{print \
        strtonum("0x"$1)%$3}')
      echo -n "Today's secret word is \"$(sed "$n q;d" ${DICTIONARY})"
      echo -n "\", now you all remember what to do when you hear the secret"
      echo " word, RIGHT!?"
    fi
}

# get the message of the day (includes WOTD)
function motd {
  if [ -z ${VIMRUNTIME} ]; then
    if which fortune > /dev/null; then
        if which cowsay > /dev/null; then
            ~/dotfiles/scripts/fortune.sh | ~/dotfiles/scripts/cowsay.sh
        else
            ~/dotfiles/scripts/fortune.sh
        fi
    else
        if which cowsay > /dev/null; then
          ~/dotfiles/scripts/ObliqueStrategies | ~/dotfiles/scripts/cowsay.sh
        else
          ~/dotfiles/scripts/ObliqueStrategies
        fi
    fi
    wotd
  else
    if which fortune > /dev/null; then
        ~/dotfiles/scripts/fortune.sh -s
    else
        ~/dotfiles/scripts/ObliqueStrategies
    fi
  fi
}

#simple calculator
function calc () { echo "$*" | bc -l; }

#tmux title changer
function tmut () {  printf "\033k$1\033\\"; }

# easy unzip
function extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)  tar xjf $1      ;;
            *.tar.gz)   tar xzf $1      ;;
            *.bz2)      bunzip2 $1      ;;
            *.rar)      rar x $1        ;;
            *.gz)       gunzip $1       ;;
            *.tar)      tar xf $1       ;;
            *.tbz2)     tar xjf $1      ;;
            *.tgz)      tar xzf $1      ;;
            *.zip)      unzip $1        ;;
            *.Z)        uncompress $1   ;;
            *)          echo "'$1' cannot be extracted via extract()" ;;
        esac
     else
        echo "'$1' is not a valid file"
     fi
}


