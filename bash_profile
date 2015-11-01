function wotd {
    local DICTIONARY=/usr/share/dict/words
    # hat-tip to flukiluke@blinkenshell for this hash:
    local n=$(echo $(date +%D|md5sum) $(wc -l ${DICTIONARY}) |  awk '{print \
        strtonum("0x"$1)%$3}')
    if [ -f $DICTIONARY ]; then
      echo -n "Today's secret word is \"$(sed "$n q;d" ${DICTIONARY})"
      echo -n "\", now you all remember what to do when you hear the secret"
      echo " word, RIGHT!?"
    fi
}

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
motd

case $OSTYPE in
    darwin*)
        # this is a mac

        export TERM=xterm-256color
        export SVN_EDITOR=vim


        # TMUX
        if which tmux 2>&1 >/dev/null; then
            # if no session is started, start a new session
            test -z ${TMUX} && tmux

            # when quitting tmux, try to attach
            while test -z ${TMUX}; do
                tmux attach || break
            done
        fi

        # kill apache/tomcat
        function kill_apache {
            ps -ae | awk '/([a]pache|[t]omcat)/ {print $1}' | xargs kill -9
        }

        alias hostsconf='sudo vi /etc/hosts'
        alias db='~/Dropbox '
        alias jksky='cd ~/Dropbox/JKsky '
        alias chrome='open -a Google\ Chrome '

        # homebrew completion
        source `brew --repository`/Library/Contributions/brew_bash_completion.sh

        # PATHs
        export NODE_PATH="/usr/local/lib/node"
        export GEM_HOME=~/gems
        [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

        # Google tools
        #PATH=$PATH:/Applications/GoogleAppEngineLauncher.app/Contents/Resources/GoogleAppEngine-default.bundle/Contents/Resources/google_appengine:~/Documents/android-sdk/platform-tools
        # Added by the Heroku Toolbelt
        export PATH="/usr/local/heroku/bin:$PATH"
        # Ruby/Gem & Npm
        PATH=$PATH:/usr/local/share/npm/bin:~/gems/bin
        # Python
        #PATH=$PATH:/System/Library/Frameworks/Python.framework/Versions/2.7/bin:/System/Library/Frameworks/Python.framework/Versions/Current/bin
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
                export GEM_HOME="~/gems"
                # add appengine, npm, and gems bins to path
                PATH=$PATH:/usr/local/bin:/usr/local/share/npm/bin
                PATH=$PATH:~/gems/bin:~/google_appengine
                ;;
            *google*)
                if [ -f ~/at_google.sh ]; then
                    source ~/at_google.sh
                fi
                export GEM_HOME=~/gems
                PATH=$PATH:~/gems/bin
        esac
        ;;
    cygwin)
        # this is a PC with cygwin
        fortune -as
        export PATH="/cygdrive/c/Program Files/Oracle/VirtualBox:$PATH"
        ;;
    msys)
        fortune -as
        export PATH="/mingw/bin:/c/Program Files/Oracle/VirtualBox:$PATH"
        ;;
    *)
        echo "$OSTYPE unknown in .bash_profile"
        ;;
esac

export EDITOR=vim
export PATH="$PATH:."
# import bashrc
source ~/.bashrc

