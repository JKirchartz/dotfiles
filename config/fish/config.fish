# per the Arch wiki, fish won't load the profile, so try this?
# source /etc/profile with bash
if status is-login
    if not set -q __sourced_profile
        set -x __sourced_profile 1
        exec bash -c "\
            test -e /etc/profile && source /etc/profile
            test -e $HOME/.profile && source $HOME/.profile
            exec fish --login
        "
    end
    
    # put your other configs below
    
    #
    
    set -e __sourced_profile
end
