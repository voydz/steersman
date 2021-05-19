#!/bin/bash

copy_if_not_exists()
{
    if [ ! -d ${STEERSMAN_CONFIG}/$1 ]; then
        cp -R /default_config/$1 ${STEERSMAN_CONFIG}/
        chown -R steersman:steersman ${STEERSMAN_CONFIG}
    fi
}

# copy default config if it does not exist
copy_if_not_exists "gcode_files"
copy_if_not_exists "klipper_config"

# launch all services through supervisor
/usr/bin/supervisord