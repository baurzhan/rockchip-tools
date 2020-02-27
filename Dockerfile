FROM  ubuntu:19.04
ENV DEBIAN_FRONTEND=noninteractive
ENV CROSS_COMPILE=arm-linux-gnueabi-
ENV JOBS=1
RUN apt-get -yqq update && apt-get -yqq --no-install-recommends install apt-utils
RUN apt-get -yqq --no-install-recommends install \
        git u-boot-tools device-tree-compiler mtools repo \
        parted libudev-dev \
        libusb-1.0-0-dev lib32gcc-7-dev \
        python-linaro-image-tools linaro-image-tools \
        gcc-arm-linux-gnueabihf gcc-aarch64-linux-gnu gcc-arm-linux-gnueabi \
        libstdc++-7-dev autoconf autotools-dev \
        libsigsegv2 m4 intltool libdrm-dev \
        curl sed make binutils build-essential \
        gcc g++ bash patch gzip bzip2 perl tar \
        cpio python unzip rsync file bc wget \
        libncurses5 cvs mercurial \
        rsync openssh-client subversion asciidoc \
        w3m dblatex python-matplotlib \
        libssl-dev pv e2fsprogs fakeroot devscripts \
        libi2c-dev libncurses5-dev texinfo liblz4-tool genext2fs 
        # libqt4-dev libglib2.0-dev libgtk2.0-dev libglade2-dev graphviz
WORKDIR /data
COPY build-kernel.sh /usr/local/bin/build-kernel
COPY split-appended-dtb /usr/src/split-appended-dtb
RUN cd /usr/src/split-appended-dtb \
    && gcc split-appended-dtb.c -o split-appended-dtb \
    && chmod +x split-appended-dtb \
    && mv split-appended-dtb /usr/local/bin/split-appended-dtb \
    && cd .. \
    && rm -rf split-appended-dtb
COPY rockchip-mkbootimg /usr/src/rockchip-mkbootimg
RUN cd /usr/src/rockchip-mkbootimg \
    && make \
    && make install \
    && cd .. \
    && rm -rf rockchip-mkbootimg
RUN chmod +x /usr/local/bin/*