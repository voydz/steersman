#!/bin/bash
# ref https://docs.mainsail.xyz/setup/manual-setup/mainsail

MAINSAIL_DIR=${STEERSMAN_HOME}/mainsail

setup_nginx()
{
    # setup nginx
    echo "daemon off;" >> /etc/nginx/nginx.conf

    # setup mainsail config
    cp ${MAINSAIL_DIR}/nginx/mainsail /etc/nginx/sites-available/mainsail
    cp ${MAINSAIL_DIR}/nginx/upstreams.conf /etc/nginx/conf.d/upstreams.conf
    cp ${MAINSAIL_DIR}/nginx/common_vars.conf /etc/nginx/conf.d/common_vars.conf

    # remove default site
    rm /etc/nginx/sites-enabled/default
    ln -s /etc/nginx/sites-available/mainsail /etc/nginx/sites-enabled/
}

install_software()
{
    wget -q -O ${MAINSAIL_DIR}/src.zip https://github.com/meteyou/mainsail/releases/latest/download/mainsail.zip

    unzip ${MAINSAIL_DIR}/src.zip -d ${MAINSAIL_DIR}/src
    rm ${MAINSAIL_DIR}/src.zip
}

# Run installation steps defined above
setup_nginx
install_software