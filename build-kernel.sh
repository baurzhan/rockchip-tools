#!/bin/bash -e
make distclean && make ARCH=$ARCH $KERNEL_DEFCONFIG && make ARCH=$ARCH $KERNEL_DTS.img -j$JOBS