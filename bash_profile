[ -s "$HOME/.profile" ] && source ~/.profile
[ -s "$HOME/.env_keys" ] && source ~/.env_keys

 # Load RVM into a shell session *as a function*
[ -s "$HOME/.rvm/scripts/rvm" ] && source "$HOME/.rvm/scripts/rvm"

[ -s "$HOME/.bashrc" ] && source ~/.bashrc # import bashrc if it's not here.

# get SSH setup
[ -s "$HOME/.ssh/id_rsa" ] && eval `keychain -q --eval --agents ssh id_rsa`
[ -s "$HOME/.ssh/id_ed25519" ] && eval `keychain -q --eval --agents ssh id_ed25519`

# motd
~/dotfiles/bin/motd.sh

# autostart screen?
# if [ "$(ps -p $PPID -o comm=)" != screen ]; then scr; fi

# RIP this mechanic
# (note: I added more control to this right before rewriting it all, so if you find it useful, go for it...)
# case $OSTYPE in
#     darwin*)
#         # this is a mac
#     ;;
#     linux*)
#        # this is linux
#        # if we need to detect OS:
#        case $(grep -oP '^NAME="\K[^ "]+' /etc/os-release) in
#           Debian)
#             ;;
#           Arch)
#             ;;
#        esac
#
#        # if we need to detect host system:
#        case "$HOSTNAME" in
#            AXE)
#                ;;
#        esac
#        ;;
#     cygwin)
#         # this is a PC with cygwin
#         PATH="$PATH:/cygdrive/c/Program Files/Oracle/VirtualBox"
#         ;;
#     msys)
#         # this is a PC with msys
#         PATH="$PATH:/mingw/bin:/c/Program Files/Oracle/VirtualBox"
#         ;;
#     *)
#         echo "$OSTYPE not recognized in .bash_profile"
#         ;;
# esac

