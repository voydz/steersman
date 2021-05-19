#!/bin/bash

# install supervisor config
mv ${STEERSMAN_DIR}/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# install dependencies
apt update \
    && apt install -y sudo supervisor git dfu-util unzip nginx wget

# add steersman user
useradd -ms /bin/bash steersman 
adduser steersman sudo
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# set initial permissions
chown -R steersman:steersman ${STEERSMAN_CONFIG}
chown -R steersman:steersman ${STEERSMAN_DIR}

# symlink config dir as an alias
# we'll see in the future how well this works
ln -s /home/steersman /config