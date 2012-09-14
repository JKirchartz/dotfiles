# mac uses bash_profile instead of bashrc
if [[ "$OSTYPE" =~ ^darwin ]]; then
    #import bashrc
    source ~/.bashrc
    
    #import exports & aliases for work
    $work=~/dotfiles/skyword
    if [[ -f $work ]]; then
        source $work
    fi
fi

