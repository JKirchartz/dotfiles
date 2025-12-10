# Bins
PATH="$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/games"

[ -s "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"
[ -s "$HOME/.linuxbrew" ] && export PATH="$PATH:$HOME/.linuxbrew/bin"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

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
export EDITOR=vim

# The Pager
export PAGER="less -F"

