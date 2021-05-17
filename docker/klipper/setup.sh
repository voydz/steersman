#!/bin/bash
# ref https://docs.mainsail.xyz/setup/manual-setup/klipper

# clone source
git clone https://github.com/KevinOConnor/klipper $KLIPPER_DIR

# run install script
su -p steersman -c "${STEERSMAN_HOME}/klipper/install.sh"


# setup env
mkdir -m 777 -p ${STEERSMAN_CONFIG}/klipper_config
mkdir -m 777 -p ${STEERSMAN_CONFIG}/gcode_files