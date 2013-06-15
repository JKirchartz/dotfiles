# test if this is my office mac
if [[ "$OSTYPE" =~ ^darwin ]]; then
    # import bashrc
    source ~/.bashrc

    # ####################
    # stuff for the 9-5
    # ####################

    function kill_apache {
        ps -ae | awk '/[a]pache/ {print $1}' | xargs kill
        # negative lookbehind doesn't work here, but a character class does
        # [a]pache matches apache but not [a]pache
    }
    export PATH=${PATH}:$JAVA_HOME:$GATHER_CONFIG:$GATHER_CONFIG_DIR:$GATHER_PROP_FILE:$CONTENTMANAGER_TOMCAT:/opt/android/tools:/usr/local/mysql/bin
    export JAVA_HOME=$(/usr/libexec/java_home)
    export GATHER_CONFIG=/home/gather/configs/gather_config.xml
    export GATHER_CONFIG_DIR=/home/gather/configs
    export GATHER_PROP_FILE=/home/gather/configs/build.properties
    #export CURRENT_CONTENTMANAGER="/Users/jkirchartz/Documents/workspace/contentManager_trunk"
    export CURRENT_CONTENTMANAGER="/Users/jkirchartz/Documents/workspace/contentManager_dragonfly"
    export CONTENTMANAGER_TOMCAT=$CURRENT_CONTENTMANAGER/apache-tomcat-6.0.14
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
    alias con='cd $CURRENT_CONTENTMANAGER'
    alias jksky='cd ~/Dropbox/JKsky'

    # homebrew completion
    source `brew --repository`/Library/Contributions/brew_bash_completion.sh
fi


# MacPorts Installer addition on 2013-02-14_at_20:37:11: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

