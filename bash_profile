case $OSTYPE in
    darwin*)
        # this is a mac
        # import bashrc
        source ~/.bashrc

        # kill apache/tomcat
        function kill_apache {
            ps -ae | awk '/([a]pache|[t]omcat)/ {print $1}' | xargs kill -9
        }

        alias hostsconf='sudo vi /etc/hosts'
        alias jksky='cd ~/Dropbox/JKsky '
        alias chrome='open -a Google\ Chrome '

        # homebrew completion
        source `brew --repository`/Library/Contributions/brew_bash_completion.sh

        ## EXPORT PATH ETC: THIS NEEDS CLEANED UP A LOT!
        export NODE_PATH="/usr/local/lib/node"
        export GEM_HOME=~/gems
        [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

        PATH="/usr/local/bin:/usr/local/sbin:$PATH"
        PATH="~/dotfiles/scripts:~/gems/bin:/Library/Frameworks/Python.framework/Versions/2.7/bin:/Library/Frameworks/Python.framework/Versions/Current/bin:${PATH}"
        PATH=/opt/local/bin:/opt/local/sbin:$PATH
        #node path
        PATH="/usr/local/share/npm/bin:$PATH"

        #GAE path
        PATH="/Applications/GoogleAppEngineLauncher.app/Contents/Resources/GoogleAppEngine-default.bundle/Contents/Resources/google_appengine:$PATH"

        # brew/macports bins & android sdk
        export PATH=/opt/local/bin:/opt/local/sbin:~/Documents/android-sdk/platform-tools/:$PATH
        ;;

    linux*)
        # this is linux
        ;;

    *BSD*)
        # this is a flavor of BSD
        ;;

    cygwin)
        # this is a PC with cygwin
        echo "cygwin!? May God have mercy on your soul."
        ;;

    *)
        echo "$OSTYPE unknown in .bash_profile"
        ;;
esac
