#!/bin/bash
# ref https://docs.mainsail.xyz/setup/manual-setup/mainsail

NGINX_CONFIG=${STEERSMAN_DIR}/mainsail/nginx

setup_nginx()
{
    # setup mainsail config
    cp ${NGINX_CONFIG}/mainsail /etc/nginx/sites-available/mainsail
    cp ${NGINX_CONFIG}/upstreams.conf /etc/nginx/conf.d/upstreams.conf
    cp ${NGINX_CONFIG}/common_vars.conf /etc/nginx/conf.d/common_vars.conf

    # remove default site
    rm /etc/nginx/sites-enabled/default
    ln -s /etc/nginx/sites-available/mainsail /etc/nginx/sites-enabled/
}

install_software()
{
    wget -q -O /tmp/mainsail.zip https://github.com/meteyou/mainsail/releases/latest/download/mainsail.zip
    unzip /tmp/mainsail.zip -d ${MAINSAIL_DIR}
}

# Run installation steps defined above
setup_nginx
install_software