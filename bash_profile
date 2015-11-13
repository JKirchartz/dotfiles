motd

case $OSTYPE in
    darwin*)
        # this is a mac
        export TERM=xterm-256color

        # TMUX
        if which tmux 2>&1 >/dev/null; then
            # if no session is started, start a new session
            test -z ${TMUX} && tmux
            # when quitting tmux, try to attach
            while test -z ${TMUX}; do
                tmux attach || break
            done
        fi

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
        # this is a PC with msys
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

