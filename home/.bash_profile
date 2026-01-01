. "$HOME/.profile"
. "$HOME/.bashrc"

# Load RVM into a shell session *as a function*
# shellcheck source=/dev/null
[ -s "$HOME/.rvm/scripts/rvm" ] && . "$HOME/.rvm/scripts/rvm"


if [ -z "$SSH_AGENT_PID" ]; then
  keys=$(find "$HOME/.ssh" -type f | grep pub | rev | cut -f2- -d'.' | rev);
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
  eval "$(ssh-agent -s)" &>/dev/null
  ssh-add -q "$keys"
  fi
fi
