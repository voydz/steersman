#!/bin/bash
# ref https://docs.mainsail.xyz/setup/manual-setup/mainsail

# run install script
${STEERSMAN_DIR}/mainsail/install.sh

chown -R steersman:steersman ${MAINSAIL_DIR}