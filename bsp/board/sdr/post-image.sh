#!/bin/bash

set -e

TARGET_PATH=$1

BOARD_DIR="$(dirname $0)"
BOARD_NAME="$(basename ${BOARD_DIR})"

# By default U-Boot loads DTB from a file named "devicetree.dtb", so
# let's use a symlink with that name that points to the *first*
# devicetree listed in the config.




################################################################################
#
################################################################################
function BuildFlashImage
{
#    if [ -z "$PRODUCT_FW_VERSION" ]; then
#        LOG_WARNING "Undefined product version!"
#        PRODUCT_FW_VERSION="undefined"
#    else
#        echo $PRODUCT_FW_VERSION
#    fi

    ln -fs ${BINARIES_DIR}/sdr.dtb ${BINARIES_DIR}/devicetree.dtb



#    cp "${BOARD_DIR}/uEnv.txt" "${BINARIES_DIR}/uEnv.txt"

    support/scripts/genimage.sh -c "${BOARD_DIR}/genimage.cfg"

}

################################################################################
#
################################################################################
function BuildUpdateImage
{
    if [ -z "$PRODUCT_FW_VERSION" ]; then
        echo "Undefined product version!"
        PRODUCT_FW_VERSION="undefined"
    else
        echo $PRODUCT_FW_VERSION
    fi

    sed -e "s/@@FW_VERSION@@/$PRODUCT_FW_VERSION/" "${BOARD_DIR}/sw-description" > ${BINARIES_DIR}/sw-description

    cp "${BOARD_DIR}/update.sh"      ${BINARIES_DIR}/

    #openssl dgst -sha256 -sign swupdate-priv.pem sw-description > sw-description.sig
    SWU_FNAME="${BOARD_NAME}_update_${PRODUCT_FW_VERSION}.swu"
    (
        cd ${BINARIES_DIR}/

        gzip -k -f rootfs.ext4

        FILES="sw-description rootfs.ext4.gz update.sh"

        for i in $FILES;do
            echo $i;done | cpio -ov -H crc > ${SWU_FNAME}
    )

    LATEST_SWU_FNAME="${BINARIES_DIR}/${BOARD_NAME}_latest.swu"

    ln -s -f ${SWU_FNAME} ${LATEST_SWU_FNAME}
}

################################################################################
# Main function
################################################################################
function MAIN 
{
    BuildFlashImage
    BuildUpdateImage
}

MAIN

exit $?
