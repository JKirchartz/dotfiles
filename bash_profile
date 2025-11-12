# motd
~/dotfiles/scripts/motd.sh

# Bins
PATH="$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/games"

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
            Gibson)
                export PATH="$PATH:/usr/local/opt/node@12/bin"
                export TODO_DIR="/mnt/g/My\ Drive/todo/"
                alias open="/mnt/c/Windows/explorer.exe ."
                [ -s "$HOME/.ssh/id_rsa" ] && eval `keychain -q --eval --agents ssh id_rsa`
                [ -s "$HOME/.ssh/id_ed25519" ] && eval `keychain -q --eval --agents ssh id_ed25519`
                # export DISPLAY=:0;
                export LIBGL_ALWAYS_INDIRECT=1;
                alias pbcopy="$HOME/dotfiles/scripts/wsl-pbcopy.sh"
                alias pbpaste="$HOME/dotfiles/scripts/wsl-pbpaste.sh"
                # export DISPLAY=$(grep -oP "($?<=nameserver ).+" /etc/resolv.conf):0.0
                export PATH="$PATH:$HOME/.cargo/bin/"
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

if [[ -f ~/.env_keys ]];then
    source ~/.env_keys
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
