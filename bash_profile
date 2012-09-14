if [[ "$OSTYPE" =~ ^darwin ]]; then
    source ~/.bashrc
fi

export PATH=${PATH}:$JAVA_HOME:$GATHER_CONFIG:$GATHER_CONFIG_DIR:$GATHER_PROP_FILE:$CONTENTMANAGER_TOMCAT:/opt/android/tools:/usr/local/mysql/bin

export JAVA_HOME=$(/usr/libexec/java_home)

export GATHER_CONFIG=/home/gather/configs/gather_config.xml
export GATHER_CONFIG_DIR=/home/gather/configs
export GATHER_PROP_FILE=/home/gather/configs/build.properties

export CURRENT_CONTENTMANAGER="/Users/mspringer/Documents/workspace/contentManager_trunk"
export CONTENTMANAGER_TOMCAT=/Users/mspringer/Documents/workspace/contentManager_trunk/apache-tomcat-6.0.14

# dealing with Java & ant deployment
alias kj='killall -9 java && say die java scum!'
alias rl='killall -9 java && ant all && say relaunching now && ~/contentManager.sh'
alias rs='killall -9 java && say restarting now && ~/contentManager.sh'
alias ad='ant deploy-jsp && date'
alias aa='ant all && date && say ant all completed'
alias lp='ant all && say launching now && ~/contentManager.sh'
# other work stuff
alias gatherconf='sudo vi $GATHER_PROP_FILE'
alias con='cd $CURRENT_CONTENTMANAGER'
