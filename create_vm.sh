#!/bin/bash

rm -f vm/lifeboatx64.img
mkdir -p vm/tmp/EFI/BOOT
cp lifeboatx64.efi vm/tmp/EFI/BOOT/bootx64.efi
virt-make-fs --format=raw --partition=gpt --type=vfat --label=ESP vm/tmp vm/lifeboat.img
