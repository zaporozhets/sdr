#!/bin/bash

set -e

THIS_SCRIPT_DIR=$(readlink -f $(dirname $0))
TOP_DIR=$(readlink -f "${THIS_SCRIPT_DIR}/")


trap TRAP_CTRL_C INT

source "${TOP_DIR}/utils/bash_helpers.sh"


################################################################################
# Main function
################################################################################
function MAIN
{
    LOG_INFO "################################################################################"
    LOG_INFO "# "
    LOG_INFO "################################################################################"

    if [ -z "$PRODUCT_FW_VERSION" ]; then
        export PRODUCT_FW_VERSION="dev-$(git describe --dirty --abbrev=4 --tags --always)"
    fi

    make -C bsp/buildroot/ BR2_EXTERNAL=../ sdr_defconfig
    make -C bsp/buildroot/

    ARTIFACTS_PATH="${TOP_DIR}/artifacts/"
    mkdir -p "${ARTIFACTS_PATH}"

    mv bsp/buildroot/output/images/sdr_* "${ARTIFACTS_PATH}"
}

################################################################################
#
################################################################################
function TRAP_CTRL_C() {
    LOG_ERROR "** Trapped CTRL-C"
    exit -1
}

MAIN

exit $?
