# rockchip-tools
Tools for building rockchip firmware
## Environment variables

    CROSS_COMPILE - cross compiler prefix (default: arm-linux-gnueabi-)
	JOBS - concurrent jobs count (default: 1)
	ARCH - target architecture
	KERNEL_DEFCONFIG - kernel configuration file name
	KERNEL_DTS	- kernel DTS file name

## Build kernel
    
    docker run --rm -it -v /path/to/kernel/source/folder:/data -e ARCH=arm \
		-e KERNEL_DEFCONFIG=adw_z37_rk3288_defconfig \
		-e KERNEL_DTS=rk3288-adw-z37 oilab/rockchip-tools:latest build-kernel

## Pack firmware image

	docker run --rm -it -v /path/to/package/files/folder:/data \
		oilab/rockchip-tools:latest afptool -pack . update.img
	
	# Where /path/to/package/files/folder contains package-file, parameter.txt and image files.

## Unpack firmware image

	docker run --rm -it -v /path/to/package/files/folder:/data \
		oilab/rockchip-tools:latest afptool -unpack update.img .

	# Where /path/to/package/files/folder contains update.img file

## img_maker
```
USAGE:
docker run --rm -it -v $(pwd):/data oilab/rockchip-tools:latest \
	img_maker [chiptype] [loader] [major ver] [minor ver] [subver] [old image] [out image]

Example:
img_maker -rk30 Loader.bin 1 0 23 rawimage.img rkimage.img 	RK30 board
img_maker -rk31 Loader.bin 4 0 4 rawimage.img rkimage.img 	RK31 board
img_maker -rk32 Loader.bin 4 4 2 rawimage.img rkimage.img 	RK32 board


Options:
[chiptype]:
	-rk29
	-rk30
	-rk31
	-rk32
```

## mkbootimg
```
docker run --rm -it -v $(pwd):/data oilab/rockchip-tools:latest \
	mkbootimg \
       --kernel <filename> \
       --ramdisk <filename> \
       [ --second <2ndbootloader-filename> ] \
       [ --cmdline <kernel-commandline> ] \
       [ --board <boardname> ] \
       [ --base <address> ] \
       [ --pagesize <pagesize> ] \
       [ --ramdiskaddr <address> ] \
       -o|--output <filename>
```

## unmkbootimg
```
docker run --rm -it -v $(pwd):/data oilab/rockchip-tools:latest \
	unmkbootimg \
       [ --kernel <filename> ] \
       [ --ramdisk <filename> ] \
       [ --second <2ndbootloader-filename> ] \
       -i|--input <filename>
```

## mkrootfs
```
docker run --rm -it -v $(pwd):/data oilab/rockchip-tools:latest \
	mkrootfs directory size

# directory   Directory used for the creation of the ext4 rootfs image
# size        Image size in 'dd' format (eg. 256M, 512M, 1G, etc.)
```

## mkupdate
```
docker run --rm -it -v $(pwd):/data oilab/rockchip-tools:latest \
	mkupdate directory

# directory must contain package-file with bootloader, parameter and image files
```

## mkcpiogz
```
docker run --rm -it -v $(pwd):/data oilab/rockchip-tools:latest \
	mkcpiogz directory
```

## unmkcpiogz
```
docker run --rm -it -v $(pwd):/data oilab/rockchip-tools:latest \
	unmkcpiogz initramfs.cpio.gz
```

##  extract device tree source
```
# extract device tree binary from boot.img
docker run --rm -it -v $(pwd):/data oilab/rockchip-tools:latest \
	split-appended-dtb  boot.img
# decompile device tree binary
docker run --rm -it -v $(pwd):/data oilab/rockchip-tools:latest \
	dtc -I dtb -O dts -o devicetree.dts devicetree.dtb
```

## Scripts (added in version 1.1.0)
```
docker run --rm -it -v $(pwd):/data oilab/rockchip-tools:latest \
	/scripts/rk3288-mkupdate.sh

Available scripts:
	/scripts/px30-mkupdate.sh
	/scripts/px3se-mkupdate.sh
	/scripts/rk1808-mkupdate.sh
	/scripts/rk3036-mkupdate.sh
	/scripts/rk3128h-mkupdate.sh
	/scripts/rk3128-mkupdate.sh
	/scripts/rk312x-mkupdate.sh
	/scripts/rk3229-mkupdate.sh
	/scripts/rk3288-mkupdate.sh
	/scripts/rk3308-mkupdate.sh
	/scripts/rk3326-mkupdate.sh
	/scripts/rk3328-mkupdate.sh
	/scripts/rk3399-mkupdate.sh
	/scripts/unpack.sh

