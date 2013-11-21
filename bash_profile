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

        # brew/macports bins
        export PATH=/opt/local/bin:/opt/local/sbin:$PATH
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
