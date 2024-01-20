#!/usr/bin/env bash

if [[ $(id -u) == 0 ]]; then
    echo "Running as root"
    rm -f /usr/bin/sbackup
    rm -f /usr/bin/sbackup-schedule
else
    echo "Running as user ($(whoami))"
    rm -f $HOME/.local/bin/sbackup
    rm -f $HOME/.local/bin/sbackup-schedule

    echo -n "Do you want to delete the configuration file? (yes/no) "
    if [[ "$(read -r confirmation)" == "yes" ]]; then
        rm -f "${XDG_CONFIG_HOME:-$HOME/.config}/backup-config.ini"
    fi
fi

echo "Check if you want to remove any dependency from your system."

