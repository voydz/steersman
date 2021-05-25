#!/bin/bash
# ref https://docs.mainsail.xyz/setup/manual-setup/klipper

INSTALL_SCRIPT="${KLIPPER_DIR}/scripts/install-ubuntu-18.04.sh"

# clone source
git clone https://github.com/KevinOConnor/klipper ${KLIPPER_DIR}
chown -R steersman:steersman ${KLIPPER_DIR}

# do not launch in provision
sed -e s/start_software$//g -i "${INSTALL_SCRIPT}"

# change config location and add unix socket parameter
sed -e "s/\${HOME}\/printer\.cfg/\${STEERSMAN_CONFIG}\/klipper_config\/printer\.cfg -a \/tmp\/klippy_uds/g" -i "${INSTALL_SCRIPT}"

# run install script
su -l steersman -c "HOME=${STEERSMAN_DIR} STEERSMAN_CONFIG=${STEERSMAN_CONFIG} ${INSTALL_SCRIPT}"

# reset repository
cd ${KLIPPER_DIR} && git checkout .