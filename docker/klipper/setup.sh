#!/bin/bash
# ref https://docs.mainsail.xyz/setup/manual-setup/klipper

# clone source
git clone https://github.com/KevinOConnor/klipper $KLIPPER_DIR

# run install script
su -p steersman -c "${STEERSMAN_DIR}/klipper/install.sh"