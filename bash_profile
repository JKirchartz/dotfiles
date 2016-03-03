function wotd {
    local DICTIONARY=/usr/share/dict/words
    # hat-tip to flukiluke@blinkenshell for this hash:
    if [ -f $DICTIONARY ]; then
      local n=$(echo $(date +%D|md5sum) $(wc -l ${DICTIONARY}) |  awk '{print \
          strtonum("0x"$1)%$3}')
      echo -n "Today's secret word is \"$(sed "$n q;d" ${DICTIONARY})"
      echo -n "\", now you all remember what to do when you hear the secret"
      echo " word, RIGHT!?"
    fi
}

function motd {
  if [ -z "${VIMRUNTIME}" ]; then
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
  else
    if which fortune > /dev/null; then
        ~/dotfiles/scripts/fortune.sh -s
    else
        ~/dotfiles/scripts/ObliqueStrategies
    fi
  fi
}
motd

case $OSTYPE in
    darwin*)
        # this is a mac
        export TERM=xterm-256color

        # homebrew completion
        source `brew --repository`/Library/Contributions/brew_bash_completion.sh
        ;;
    linux*)
        # this is linux
        case $HOSTNAME in
            triton)
                if [ "$(ps -p $PPID -o comm=)" != screen ]; then scr; fi
                ;;
            lucid32)
                ### Added by the Heroku Toolbelt
                export PATH="/usr/local/heroku/bin:$PATH"
                ;;
            crunchbang|arp)
                export GEM_HOME=~/gems
                # add appengine, npm, and gems bins to path
                PATH=$PATH:/usr/local/bin:/usr/local/share/npm/bin
                PATH=$PATH:~/gems/bin:~/google_appengine
                ;;
        esac
        ;;
    cygwin)
        # this is a PC with cygwin
        export PATH="/cygdrive/c/Program Files/Oracle/VirtualBox:$PATH"
        ;;
    msys)
        # this is a PC with msys
        export PATH="/mingw/bin:/c/Program Files/Oracle/VirtualBox:$PATH"
        ;;
    *)
        echo "$OSTYPE unknown in .bash_profile"
        ;;
esac

export EDITOR=vim
# import bashrc
source ~/.bashrc

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
