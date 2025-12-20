[ -s "$HOME/.profile" ] && . "$HOME/.profile"
[ -s "$HOME/.bashrc" ] && . "$HOME/.bashrc"

# Load RVM into a shell session *as a function*
# shellcheck source=/dev/null
[ -s "$HOME/.rvm/scripts/rvm" ] && . "$HOME/.rvm/scripts/rvm"


if [ -z "$SSH_AGENT_PID" ]; then
  keys=$(find "$HOME/.ssh" "*id_*.pub" -type f | cut -f1 -d'.');
  # keychain SSH setup
  if command -v keychain &>/dev/null; then
      keychain -q --no-gui "$keys"
      [ -z "$HOSTNAME" ] && HOSTNAME=$(uname -n)
    # shellcheck source=/dev/null
      [ -f "$HOME/.keychain/$HOSTNAME-sh" ] && . "$HOME/.keychain/$HOSTNAME-sh"
    # shellcheck source=/dev/null
      [ -f "$HOME/.keychain/$HOSTNAME-sh-gpg" ] && . "$HOME/.keychain/$HOSTNAME-sh-gpg"
  # no keychain? just ssh then?
  else
  eval "$(ssh-agent -s)"
  ssh-add "$keys"
  fi
fi

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
