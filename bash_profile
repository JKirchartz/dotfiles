# motd
~/dotfiles/scripts/motd.sh

# Bins
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

# system-specific configs
case $OSTYPE in
    darwin*)
        # this is a mac
        export TERM=xterm-256color

        # homebrew completion
        source `brew --repository`/Library/Contributions/brew_bash_completion.sh

        # take a screenshot
        alias ss2='screencapture -xP '
        alias ss='screencapture -xwP '
        ;;
    linux*)
        # this is linux
        case $HOSTNAME in
            triton)
                # autostart screen
                if [ "$(ps -p $PPID -o comm=)" != screen ]; then scr; fi
                ;;
            lucid32)
                ### Added by the Heroku Toolbelt
                PATH="$PATH:/usr/local/heroku/bin"
                export GEM_HOME=~/gems:$GEM_HOME
                ;;
            arp)
                # add appengine, npm, and gems bins to path
                export GEM_HOME=~/gems
                PATH=$PATH:/usr/local/share/npm/bin
                PATH=$PATH:~/google_appengine
                # nvm paths
                export NVM_DIR="/home/kirch/.nvm"
                [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
                if [[ -d "$NVM_DIR" ]]; then
                  NODE_DEFAULT_VERSION="$(<"$NVM_DIR/alias/default")"
                else
                  NODE_DEFAULT_VERSION=""
                fi
                if [[ "$NODE_DEFAULT_VERSION" != "" ]]; then
                  PATH="$PATH:$NVM_DIR/versions/node/$NODE_DEFAULT_VERSION/bin"
                fi
                # Ubuntu make installation of Ubuntu Make binary symlink
                PATH=/home/kirch/.local/share/umake/bin:$PATH
                # Android
                # export ANDROID_HOME="/home/kirch/.local/share/umake/android/android-studio/"
                # export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
                ### Added by the Heroku Toolbelt
                PATH="$PATH:/usr/local/heroku/bin"
                PATH="$PATH:$HOME/.rbenv/bin"
                eval "$(rbenv init -)"
                ;;
        esac
        ;;
    cygwin)
        # this is a PC with cygwin
        PATH="$PATH:/cygdrive/c/Program Files/Oracle/VirtualBox"
        ;;
    msys)
        # this is a PC with msys
        PATH="$PATH:/mingw/bin:/c/Program Files/Oracle/VirtualBox"
        ;;
    *)
        echo "$OSTYPE not registered in .bash_profile"
        ;;
esac

export EDITOR=vim
export PAGER="less -F"

# import bashrc
source ~/.bashrc
