#/bin/bash

alpineminirootfsfile="alpine-minirootfs-3.24.4-x86_64.tar.gz"
linuxver="linux-6.18.65"

cd ./build

if [ ! -d alpine-minirootfs ]; then
    # Getting the Alpine minirootfs
    wget https://dl-cdn.alpinelinux.org/alpine/v3.24/releases/x86_64/$alpineminirootfsfile
    mkdir alpine-minirootfs
    tar -C ./alpine-minirootfs -xf $alpineminirootfsfile
fi

if [ ! -d linux ]; then
    # Getting the Linux kernel
    wget https://cdn.kernel.org/pub/linux/kernel/v6.x/$linuxver.tar.xz
    tar -xf $linuxver.tar.xz
    ln -s $linuxver linux
fi
