#!/bin/bash
# Taken from https://github.com/KevinOConnor/klipper/blob/master/scripts/install-ubuntu-18.04.sh

install_packages()
{
    # Packages for python cffi
    PKGLIST="virtualenv python-dev libffi-dev build-essential"
    # kconfig requirements
    PKGLIST="${PKGLIST} libncurses-dev"
    # hub-ctrl
    PKGLIST="${PKGLIST} libusb-dev"
    # AVR chip installation and building
    PKGLIST="${PKGLIST} avrdude gcc-avr binutils-avr avr-libc"
    # ARM chip installation and building
    PKGLIST="${PKGLIST} stm32flash libnewlib-arm-none-eabi"
    PKGLIST="${PKGLIST} gcc-arm-none-eabi binutils-arm-none-eabi libusb-1.0"

    # Update system package info
    report_status "Running apt-get update..."
    sudo apt-get update

    # Install desired packages
    report_status "Installing packages..."
    sudo apt-get install --yes ${PKGLIST}
}

create_virtualenv()
{
    report_status "Updating python virtual environment..."

    # Create virtualenv if it doesn't already exist
    [ ! -d ${KLIPPER_VENV} ] && virtualenv -p python2 ${KLIPPER_VENV}

    # Install/update dependencies
    ${KLIPPER_VENV}/bin/pip install -r ${KLIPPER_DIR}/scripts/klippy-requirements.txt
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