#!/bin/bash
# Taken from https://github.com/Arksine/moonraker/blob/master/scripts/install-moonraker.sh

install_packages()
{
    PKGLIST="python3-virtualenv python3-dev nginx libopenjp2-7"
    PKGLIST="${PKGLIST} liblmdb0 rsync zlib1g-dev"

    # Update system package info
    report_status "Running apt-get update..."
    sudo apt-get update

    # Install desired packages
    report_status "Installing packages..."
    sudo apt-get install --yes ${PKGLIST}
}

create_virtualenv()
{
    report_status "Installing python virtual environment..."

    # Create virtualenv if it doesn't already exist
    [ ! -d ${MOONRAKER_VENV} ] && virtualenv -p /usr/bin/python3 ${MOONRAKER_VENV}

    # Install/update dependencies
    ${MOONRAKER_VENV}/bin/pip install -r ${MOONRAKER_DIR}/scripts/moonraker-requirements.txt
}

# Helper functions
report_status()
{
    echo -e "\n\n###### $1"
}

verify_ready()
{
    if [ "$EUID" -eq 0 ]; then
        echo "This script must not run as root"
        exit -1
    fi
}

# Run installation steps defined above
verify_ready
install_packages
create_virtualenv