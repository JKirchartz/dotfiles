# Bins
PATH="$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/games"

[ -s "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"
[ -s "$HOME/.linuxbrew" ] && export PATH="$PATH:$HOME/.linuxbrew/bin"


# ruby stuff
if [ -d "$HOME/gems" ]; then
    export GEM_HOME=$HOME/gems
    export PATH="$PATH:$HOME/gems/bin"
fi

# node stuff
if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    # This loads nvm
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    # This loads nvm bash_completion
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

# rust stuff
if [ -d "$HOME/.cargo" ]; then
        export PATH="$PATH:$HOME/.cargo/bin/"
fi

# perl stuff
if [ -d "$HOME/perl5" ]; then
        PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}";
        export PERL5LIB;
        PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}";
        export PERL_LOCAL_LIB_ROOT;
        export PERL_MB_OPT="--install_base \"$HOME/perl5\"";
        export PERL_MM_OPT="INSTALL_BASE=$HOME/perl5";
        export PATH="$HOME/perl5/bin${PATH:+:${PATH}}";
fi

# all the stuff for if this is WSL
if [ -z "${WSL_DISTRO_NAME+1}" ]; then
        # export DISPLAY=:0;
        # export DISPLAY=$(grep -oP "($?<=nameserver ).+" /etc/resolv.conf):0.0
        export PATH="$PATH:/usr/local/opt/node@12/bin"
        export LIBGL_ALWAYS_INDIRECT=1;
        export TODO_DIR="/mnt/g/My\ Drive/todo/"
fi

# The Editor
export VISUAL=vim
export EDITOR=$VISUAL

# The Pager
export PAGER="less -F"

# XDG compatibility:
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_STATE_HOME=${XDG_DATA_HOME:-$HOME/.local/state}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-/run/user/$UID}

# Forced Conversions
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
export ACKRC="$XDG_CONFIG_HOME"/ack/ackrc
# if less version is 598 or earlier, this might not work:
export LESSHISTFILE="$XDG_STATE_HOME"/lesshst
export SCREENRC="$XDG_CONFIG_HOME"/screen/screenrc
export TLDR_CACHE_DIR="$XDG_CACHE_HOME"/tldr

# These are necessarily part of my usual workflow, but they might get some use....
# zsh
export ZPLUG_HOME="$XDG_DATA_HOME"/zplug
export ZDOTDIR="$XDG_CONFIG_HOME"/zsh
# docker (duh)
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
# rust
export CARGO_HOME="$XDG_CDATA_HOME"/cargo
# ruby
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle
# this doesn't exist yet
# export rvm_path="$XDG_DATA_HOME"/rvm
# node
export NPM_CONFIG_INIT_MODULE="$XDG_CONFIG_HOME"/npm/config/npm-init.js
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME"/npm
export NPM_CONFIG_TMP="$XDG_RUNTIME_DIR"/npm

# sshhh...
export NETHACKOPTIONS=color,hilite_pet,boulder:8

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# put this last, my scripts always get preference this is insecure because
# various bins are overwritten by my script directory versions, for security
# move $PATH to the beginning of the assignment
export PATH="$HOME/dotfiles/bin:$PATH"
