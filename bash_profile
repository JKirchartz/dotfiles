# motd
~/dotfiles/scripts/motd.sh

# Bins
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/games"

# system-specific configs
case $OSTYPE in
    darwin*)
        # this is a mac
        export BASH_SILENCE_DEPRECATION_WARNING=1 # stop telling me about zsh!
        export TERM=xterm-256color
        export GEM_HOME=$HOME/gems
        PATH=$PATH:$HOME/gems/bin
        PATH=$PATH:$HOME/projects/ghint/
        if hash nvm 2>/dev/null; then
                export NVM_DIR="$HOME/.nvm"
                . "/usr/local/opt/nvm/nvm.sh"
        fi
        export NVM_DIR="$HOME/.nvm"
        [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
        [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

        # take a screenshot
        alias ss2='screencapture -xP '
        alias ss='screencapture -xwP '
        export EDITOR="vim"
        export VISUAL="$EDITOR"
        alias vlc='/Applications/VLC.app/Contents/MacOS/VLC -I rc -q'
        export GOPATH=$HOME/Go
        export GOROOT=/usr/local/opt/go/libexec
        export BENPROJECTROOT=$HOME/projects/TCDEAppService
        export PATH="$HOME/.gem/ruby/2.6.0/bin:$PATH"
        export PATH="$PATH:/usr/local/share/dotnet/dotnet"
        source ~/.iterm2_shell_integration.bash

        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init -)"


        test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash" || true
    ;;
    linux*)
        # this is linux

        if [ -d $HOME/.linuxbrew ]; then
          export PATH="/home/kirch/.linuxbrew/bin:$PATH"
        fi
        export EDITOR=vim

        case $HOSTNAME in
            triton)
                # autostart screen
                # if [ "$(ps -p $PPID -o comm=)" != screen ]; then scr; fi
                ;;
            AXE)
                export GEM_HOME=~/gems
                export NVM_DIR="$HOME/.nvm"
                [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
                [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
                export PATH="$HOME/.local/bin:$HOME/gems/bin:$PATH"
                PATH="/home/kirch/perl5/bin${PATH:+:${PATH}}"; export PATH;
                PERL5LIB="/home/kirch/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
                PERL_LOCAL_LIB_ROOT="/home/kirch/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
                PERL_MB_OPT="--install_base \"/home/kirch/perl5\""; export PERL_MB_OPT;
                PERL_MM_OPT="INSTALL_BASE=/home/kirch/perl5"; export PERL_MM_OPT;
                alias open="/mnt/c/Windows/explorer.exe ."
                [ -s "$HOME/.ssh/id_rsa" ] && eval `keychain -q --eval --agents ssh id_rsa`
                [ -s "$HOME/.ssh/id_ed25519" ] && eval `keychain -q --eval --agents ssh id_ed25519`
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
                # vagrant
                export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
                export PATH="$PATH:/mnt/c/Program Files/Oracle/VirtualBox"

                PATH="/home/kirch/perl5/bin${PATH:+:${PATH}}"; export PATH;
                PERL5LIB="/home/kirch/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
                PERL_LOCAL_LIB_ROOT="/home/kirch/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
                PERL_MB_OPT="--install_base \"/home/kirch/perl5\""; export PERL_MB_OPT;
                PERL_MM_OPT="INSTALL_BASE=/home/kirch/perl5"; export PERL_MM_OPT;
                ;;
            fiddle)
                export DISPLAY=:0
                export BROWSER=/mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe
                export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
                # VAGRANT_WSL_WINDOWS_ACCESS_USER - Override current Windows username
                # VAGRANT_WSL_DISABLE_VAGRANT_HOME - Do not modify the VAGRANT_HOME variable
                # VAGRANT_WSL_WINDOWS_ACCESS_USER_HOME_PATH - Custom Windows system home path
                export PATH="$PATH:/mnt/c/Program Files/Oracle/VirtualBox"
                export PATH="$PATH:/mnt/c/Windows/System32"
                alias vi=vim
                eval "$(pyenv init -)"
                eval "$(pyenv virtualenv-init -)"
                ;;
            nao*)
                export GEM_HOME=$HOME/gems
                PATH=$PATH:$HOME/gems/bin
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

export PATH="$PATH:/usr/local/opt/node@12/bin"

if [[ -f ~/.env_keys ]];then
    source ~/.env_keys
fi
