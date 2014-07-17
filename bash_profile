function cowmotd {
        # login message
        if which fortune > /dev/null; then
            if which cowsay > /dev/null; then
                fortune -as | cowsay
            else
                fortune -as
            fi
        fi
}

case $OSTYPE in
    darwin*)
        # this is a mac
        # import bashrc
        source ~/.bashrc

        export TERM=xterm-256color
        export SVN_EDITOR=vim

        cowmotd

        # login message
        if which fortune > /dev/null; then
            if which cowsay > /dev/null; then
                fortune -as | cowsay
            else
                fortune -as
            fi
        fi

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
        # Bins
        export PATH=$PATH:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin
        ;;
    linux*)
        # this is linux
        # import bashrc
        source ~/.bashrc
        case $HOSTNAME in
            triton)
                if [ "$(ps -p $PPID -o comm=)" != screen ]; then scr; fi
                ;;
            lucid32)
                cowmotd
                ### Added by the Heroku Toolbelt
                export PATH="/usr/local/heroku/bin:$PATH"
                ;;
        esac
        ;;
    *BSD*)
        # this is a flavor of BSD
        cowmotd
        ;;

    cygwin)
        # this is a PC with cygwin
        echo "cygwin!? May God have mercy on your soul."
        cowmotd
        ;;

    *)
        echo "$OSTYPE unknown in .bash_profile"
        ;;
esac
