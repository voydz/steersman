#!/bin/bash
# ref https://docs.mainsail.xyz/setup/manual-setup/moonraker

INSTALL_SCRIPT="${MOONRAKER_DIR}/scripts/install-moonraker.sh"

# clone source
git clone https://github.com/Arksine/moonraker.git ${MOONRAKER_DIR}
chown -R steersman:steersman ${MOONRAKER_DIR}

# do not launch in provision
sed -e s/start_software$//g -i "${INSTALL_SCRIPT}"

# run install script
su -l steersman -c "HOME=${STEERSMAN_DIR} ${INSTALL_SCRIPT} -c ${STEERSMAN_CONFIG}/klipper_config/moonraker.conf"

# reset repository
cd ${MOONRAKER_DIR} && git checkout .