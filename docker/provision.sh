#!/bin/bash

# install systemd replacement
# ref https://github.com/gdraheim/docker-systemctl-replacement
mv ${STEERSMAN_DIR}/systemctl3.py /usr/bin/systemctl
chmod +x /usr/bin/systemctl

# install dependencies
apt update \
    && apt install -y sudo git dfu-util unzip nginx wget

# add steersman user
useradd -ms /bin/bash steersman 
adduser steersman sudo
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# set initial permissions
chown -R steersman:steersman ${STEERSMAN_CONFIG}
chown -R steersman:steersman ${STEERSMAN_DIR}

# symlink config dir as an alias
# we'll see in the future how well this works
ln -s ${STEERSMAN_CONFIG} /config