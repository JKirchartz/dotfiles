# test if this is my office mac
if [[ "$OSTYPE" =~ ^darwin ]]; then
    # import bashrc
    source ~/.bashrc

    # ####################
    # stuff for the 9-5
    # ####################

    function kill_apache {
        ps -ae | awk '/([a]pache|[t]omcat)/ {print $1}' | xargs kill -9
    }
    export JAVA_HOME=$(/usr/libexec/java_home)
    export GATHER_CONFIG=/home/gather/configs/gather_config.xml
    export GATHER_CONFIG_DIR=/home/gather/configs
    export GATHER_PROP_FILE=/home/gather/configs/build.properties
    export CM_Current="/Users/jkirchartz/Documents/workspace/contentManager_trunk"
    export CM_Previous="/Users/jkirchartz/Documents/workspace/contentManager_dragonfly"
    export CURRENT_CONTENTMANAGER=$CM_Current
    export CONTENTMANAGER_TOMCAT=$CURRENT_CONTENTMANAGER/apache-tomcat-6.0.14
    function toggleCM {
        if [ $CURRENT_CONTENTMANAGER = $CM_Current ]; then
            export CURRENT_CONTENTMANAGER=$CM_Previous
        elif [ $CURRENT_CONTENTMANAGER = $CM_Previous ]; then
            export CURRENT_CONTENTMANAGER=$CM_Current
        else 
            echo "uh-oh, if you're seeing this something went horribly wrong"
        fi
        export PATH=${PATH//$CONTENTMANAGER_TOMCAT/}
        export CONTENTMANAGER_TOMCAT=$CURRENT_CONTENTMANAGER/apache-tomcat-6.0.14
        export PATH=$PATH:$CONTENTMANAGER_TOMCAT
        echo "CURRENT_CONTENTMANAGER is now " $CURRENT_CONTENTMANAGER
    }
    # these aliases talk because they're from the future.
    alias kj='kill_apache && say -v Trinoids die java scum!'
    alias rl='kill_apache && ant all && say -v Trinoids relaunching now && ~/contentManager.sh'
    alias url='svn update && kill_apache && ant all && say -v Trinoids relaunching now && ~/contentManager.sh'
    alias rs='kill_apache && say -v Trinoids restarting now && ~/contentManager.sh'
    alias rs='svn update && kill_apache && say -v Trinoids restarting now && ~/contentManager.sh'
    alias ad='ant deploy-jsp && fortune -as' # say something fun when I deploy
    alias aa='ant all && date && say -v Trinoids ant all completed'
    alias lp='ant all && say -v Trinoids launching now && ~/contentManager.sh'
    alias ulp='svn update && ant all && say -v Trinoids launching now && ~/contentManager.sh'
    alias gatherconf='sudo vi $GATHER_CONFIG'
    alias hostsconf='sudo vi /etc/hosts'
    alias con='cd $CURRENT_CONTENTMANAGER '
    alias jksky='cd ~/Dropbox/JKsky '

    export PATH=${PATH}:$JAVA_HOME:$GATHER_CONFIG:$GATHER_CONFIG_DIR:$GATHER_PROP_FILE:$CONTENTMANAGER_TOMCAT:/opt/android/tools:/usr/local/mysql/bin

    # homebrew completion
    source `brew --repository`/Library/Contributions/brew_bash_completion.sh
fi

# MacPorts Installer addition on 2013-02-14_at_20:37:11: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

