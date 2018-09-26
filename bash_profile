# motd
~/dotfiles/scripts/motd.sh

# Bins
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/games"

# system-specific configs
case $OSTYPE in
    darwin*)
        # this is a mac
        export TERM=xterm-256color
        export GEM_HOME=$HOME/gems
        PATH=$PATH:$HOME/gems/bin
				PATH=$PATH:$HOME/projects/ghint/
        if hash nvm 2>/dev/null; then
                export NVM_DIR="$HOME/.nvm"
                . "/usr/local/opt/nvm/nvm.sh"
        fi

        # take a screenshot
        alias ss2='screencapture -xP '
        alias ss='screencapture -xwP '
				alias editbanner='vim *.js *.less *.html'
        export EDITOR="vim"
        export VISUAL="$EDITOR"
        alias vlc='/Applications/VLC.app/Contents/MacOS/VLC -I rc -q'
        function fix-ssh {
            eval $(ssh-agent);
            ssh-add -K;
        }
    ;;
    linux*)
        # this is linux
        export EDITOR=vim

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
            archbox)
                alias vi=vim
                export NVM_DIR="$HOME/.nvm"
                [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
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
            fiddle)
                export DISPLAY=:0
                export BROWSER=/mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe
                export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
                # VAGRANT_WSL_WINDOWS_ACCESS_USER - Override current Windows username
                # VAGRANT_WSL_DISABLE_VAGRANT_HOME - Do not modify the VAGRANT_HOME variable
                # VAGRANT_WSL_WINDOWS_ACCESS_USER_HOME_PATH - Custom Windows system home path
                export PATH="$PATH:/mnt/c/Program Files/Oracle/VirtualBox"
                alias vi=vim
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

export PAGER="less -F"

# import bashrc
source ~/.bashrc

if [ -d $HOME/.linuxbrew ]; then
  export PATH="/home/kirch/.linuxbrew/bin:$PATH"
fi
