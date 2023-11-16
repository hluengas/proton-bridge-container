#!/usr/bin/env bash

# function to unlock the gnome keyring daemon
function unlock_gnome_keyring() {
  eval $(echo -en "$PROTON_KEYRING_PASSPHRASE" | gnome-keyring-daemon --unlock | sed -e 's/^/export /')
  echo '' >&2
}

# launch dbus daemon
dbus-uuidgen | tee /var/lib/dbus/machine-id
mkdir -p /var/run/dbus
dbus-daemon --config-file=/usr/share/dbus-1/system.conf --print-address

# run login script
unlock_gnome_keyring
echo "keyring unlocked... running proton bridge login script..."
/proton/scripts/login.exp

# run proton-bridge as a daemon
unlock_gnome_keyring
echo "keyring unlocked... running login proton bridge daemon..."
/proton/proton-bridge --noninteractive
