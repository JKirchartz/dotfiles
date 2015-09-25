function cowmotd {
  if [ -z ${VIMRUNTIME} ]; then
    if which fortune > /dev/null; then
        if which cowsay > /dev/null; then
            fortune -as | ~/dotfiles/scripts/cowsay.sh
        else
            fortune -as
        fi
    else
        if which cowsay > /dev/null; then
          ~/dotfiles/scripts/ObliqueStrategies | ~/dotfiles/scripts/cowsay.sh 
        else
          ~/dotfiles/scripts/ObliqueStrategies
        fi
    fi
    echo -n "Today's secret word is: "
    if type shuf > /dev/null; then
      cat /usr/share/dict/words | grep -v "'" | shuf -n1
    else
      cat /usr/share/dict/words | grep -v "'" | sort -R | head -n 1
    fi
    echo "You all know what to do when somebody says the secret word, right?"
  else
    if which fortune > /dev/null; then
      fortune -as
    else
      ~/dotfiles/scripts/ObliqueStrategies
    fi
  fi
}


cowmotd

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
            crunchbang)
                export GEM_HOME="~/gems"
                # add appengine, npm, and gems bins to path
                PATH=$PATH:/usr/local/share/npm/bin:~/gems/bin:~/google_appengine
                ;;
            *google*)
                if [ -f ~/at_google.sh ]; then
                    source ~/at_google.sh
                fi
                export GEM_HOME=~/gems
                PATH=$PATH:~/gems/bin
        esac
        ;;
    *BSD*)
        # this is a flavor of BSD
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

