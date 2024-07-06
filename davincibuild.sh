#!/bin/bash
# based on the instructions from edk2-platform
set -e
. build_common.sh
# 编译前需清除残留
PYTHON_COMMAND=python2.7
rm -rf workspace/Build/F11/DEBUG_GCC5/FV/Ffs/7E374E25-8E01-4FEE-87F2-390C23C606CDFVMAIN
# not actually GCC5; it's GCC7 on Ubuntu 18.04.
GCC5_AARCH64_PREFIX=aarch64-linux-gnu- build -s -n 0 -a AARCH64 -t GCC5 -p F11/davinci.dsc
gzip -c < Build/F11/DEBUG_GCC5/FV/F11_UEFI.fd >uefi_image5
cat davinci.dtb >> uefi_image5
abootimg --create davinci_uefi_v1.img -k uefi_image5 -r ramdisk-null -f bootimg.cfg
rm uefi_image* Build/ -rf
