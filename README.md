## Fork from Teo

I wanted to compile the project myself and discovered the scripts contain several errors. I fixed some of them and deleted some other files. Compilation time on a very weak Intel N6000 processor with only 4 threads is about 30 minutes. Otherwise you can download directly the executables from the releases page, if you trust me. Compilation from source (which you know is clean and secure) takes several minutes on a decent machine. NOTE that during compilation, you might want to kill stupid OS indexing or tumbnailer services, like tumblerd on xfce. Otherwise the compilation time will rise significantly.

My primary motivation was to be able to fsck the filesystem in case of, for example, power loss, withouth needing live usb system for this. But the "distro" includes oder filesystem and partitioning tools so can actually do more.

You have to of course also think how you will start your efi file. You can make an efi variable, chainload from some bootloader, etc. What i personally did is installing a UEFI shell as the fallback uefi executable (the default entry in BOOT/bootx64.efi) and navigate from there to my other subfolders and efi files with simple cd and ls commands. NOTE that in an efi shell you will only have US keyboard layout!! You can get a uefi shell from every linux edk2-shell package or directly from Tianocore.

Alternatively, you can add it to your existing GRUB config in the file `/etc/grub.d/40_custom` and then `sudo update-grub`

`menuentry "Lifeboat" {
search --no-floppy --fs-uuid --set=root C557-4CD1
chainloader /EFI/lifeboat/lifeboatx64.efi
}
`

Here is how it looks booted (sorry for the quality, i will make a VM and make a screenshot there):


![lifeboat_screen_small](https://github.com/user-attachments/assets/23a5de54-9f00-420b-a217-0a8bf5e5b1c1)



List of the included tools in the current version:

`openrc busybox-openrc busybox-mdev-openrc haveged 
bash gawk grep sed util-linux nano font-terminus kbd
unzip tar zstd mtools net-tools pigz pixz 
partclone partclone-utils partimage parted 
efibootmgr gptfdisk 
lvm2 cryptsetup dmraid mdadm 
e2fsprogs e2fsprogs-extra dosfstools xfsprogs btrfs-progs`



Below is the original text from Hugochinchilla before my fork:

## Lifeboat Linux

Live linux distro combined in one ~35MB file. Runs as a EFI binary so it should run on any UEFI computer (PC or Mac) without installation. Just copy one file to EFI system partition and boot.

<img width="200px" alt="Lifeboat Linux" src="lifeboat.png" />



## Motivation

Sometimes I mess my computer and need to use a live USB to be able to access my filesystem and edit some config file to bring it back to life.

I was inspired by [OneFileLinux](https://github.com/zhovner/OneFileLinux) to create a minimal rescue system based on that idea so I don't need a live USB anymore. 


**Acknowledgments:**

- [Zhovner](https://github.com/zhovner/OneFileLinux) for OneFileLinux. 
- [D4rk4](https://github.com/D4rk4/OneRecovery) for it's OneFileLinux fork with updated kernel and alpine versions.


## What to expect

This distro can be used to access your filesystem and perform basic tasks as edit config files. It can be also handy to resize partitions.

Cabled networking is supported, wireless support is not due to the need to add too many drivers and firmwares, maybe some day I will make an extended variant with wireless support.

**What's included?:**

- parted
- efibootmgr
- filesystems: ext4, ext3, btrfs, xfs, dos and their related utilities.
- lvm2
- mdadm
- dmraid
- dm-crypt
- cryptsetup
- gptfdisk
- fdisk


## Building

```
make clean build
```

The look in dist folder for `LifeboatLinux.efi`


**Incremental builds**

Incremental buils are possible for quick iterations but are prone to contamination by the previous build process. Just do `make build`.

Depending on what you are trying to do you may need to make some manual cleanup first on the rootfs dir, if you know what you are doing it will probably be ok for testing, but always prefer a clean build for final use.


## Installing

Get the EFI file (or build it) and drop it in your EFI folder. If using secure boot remember to sign it. I won't cover how to add it to your bootloader because there are many possible setups to cover it here.

## User customization

You can place a directory in your ESP partition with custom scripts, notes, or whatever you want.

Place custom resources on `(ESP partition)/EFI/Boot/Lifeboat/UserScripts`.

If you create a special file named `init` this file will be executed by the shell on login, you can use it to customize the keyboard layout, font-size, set custom shell aliases, etc.
