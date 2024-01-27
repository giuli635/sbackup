#!/usr/bin/env bash

DEPENDENCIES=("tar" "zstd" "yad" "python")

for command in "${DEPENDENCIES[@]}"
do
    if [[ ! $(command -v $command) ]]; then
        echo "$command not found, please install it."
    fi
done

if [[ ! "$(systemctl is-enabled atd)" == "enabled" ]]; then
    echo "at is not enabled or is not found in the system"
fi

if [[ $(id -u) == 0 ]]; then
    echo "Running root installation"
    install sbackup sbackup-schedule /usr/bin/
    touch /var/log/sbackup.log
    chmod 766 /var/log/sbackup.log 
else
    echo "Running user installation ($(whoami))"
    install sbackup sbackup-schedule $HOME/.local/bin/
    config_file_path="${XDG_CONFIG_HOME:-$HOME/.config}/backup-config.ini"

    if [[ -e "$config_file_path" ]]; then
        echo "Configuration file already exists"
    else
        touch "$config_file_path"
    fi

    echo "Creating the log file"
    sudo touch /var/log/sbackup.log
    sudo chmod 766 /var/log/sbackup.log 
fi

