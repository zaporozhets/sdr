#!/bin/bash

set -e


THIS_SCRIPT_DIR=$(readlink -f $(dirname $0))

TOP_DIR=$(readlink -f "${THIS_SCRIPT_DIR}/")


################################################################################
# Main function
################################################################################
function MAIN
{
    FW_NAME="${TOP_DIR}/artifacts/sdr_latest.swu"
    TARGET="dev"

    echo "Using target: ${TARGET}"

    scp ${FW_NAME} ${TARGET}:/mnt/userdata/

    ssh ${TARGET} "swupdate -v -i /mnt/userdata/sdr_latest.swu"

    ssh ${TARGET} "reboot"
}

################################################################################
#
################################################################################
function TRAP_CTRL_C() {
    LOG_ERROR "** Trapped CTRL-C"
    exit -1
}

MAIN $@

exit $?
