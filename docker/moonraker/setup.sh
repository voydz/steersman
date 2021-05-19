#!/bin/bash
# ref https://docs.mainsail.xyz/setup/manual-setup/moonraker

# clone source
git clone https://github.com/Arksine/moonraker.git $MOONRAKER_DIR

# run install script
su -p steersman -c "${STEERSMAN_DIR}/moonraker/install.sh"