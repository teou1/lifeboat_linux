#/bin/bash

alpineminirootfsfile="alpine-minirootfs-3.23.2-x86_64.tar.gz"
linuxver="linux-6.18.2"

cd ./build

if [ ! -d alpine-minirootfs ]; then
    # Getting the Alpine minirootfs
    wget -c4 http://dl-cdn.alpinelinux.org/alpine/v3.23/releases/x86_64/$alpineminirootfsfile
    mkdir alpine-minirootfs
    tar -C ./alpine-minirootfs -xf $alpineminirootfsfile
fi

if [ ! -d linux ]; then
    # Getting the Linux kernel
    wget http://cdn.kernel.org/pub/linux/kernel/v6.x/$linuxver.tar.xz
    tar -xf $linuxver.tar.xz
    ln -s $linuxver linux
fi
