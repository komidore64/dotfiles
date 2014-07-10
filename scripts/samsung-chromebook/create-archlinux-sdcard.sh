#!/bin/bash

# this script made from the instruction found on http://archlinuxarm.org/platforms/armv7/samsung/samsung-chromebook
# for a sdcard

# unmount all the partitions on the sdcard
umount /dev/mmcblk1*

# exit if anything goes wrong
set -e

# trace the script
set -x

# create a new GPT partition table
parted --script /dev/mmcblk1 mklabel gpt

# partition the sdcard
cgpt create -z /dev/mmcblk1
cgpt create /dev/mmcblk1
cgpt add -i 1 -t kernel -b 8192 -s 32768 -l U-Boot -S 1 -T 5 -P 10 /dev/mmcblk1
cgpt add -i 2 -t data -b 40960 -s 32768 -l Kernel /dev/mmcblk1
cgpt add -i 12 -t data -b 73728 -s 32768 -l Script /dev/mmcblk1
cgpt add -i 3 -t data -b 106496 -s $(expr $(cgpt show /dev/mmcblk1 | grep 'Sec GPT table' | awk '{print $1}') - 106496) -l Root /dev/mmcblk1

# refresh the system's partition list
partprobe /dev/mmcblk1

# format the partitions
mkfs.ext2 /dev/mmcblk1p2
mkfs.ext4 /dev/mmcblk1p3
mkfs.vfat -F 16 /dev/mmcblk1p12

# download the extract the root filesystem
cd /tmp
[[ -e ArchLinuxARM-chromebook-latest.tar.gz ]] || wget http://archlinuxarm.org/os/ArchLinuxARM-chromebook-latest.tar.gz
[[ -d root ]] || mkdir root
mount /dev/mmcblk1p3 root
tar -xf ArchLinuxARM-chromebook-latest.tar.gz -C root

# copy the kernel to the the kernel partition
[[ -d mnt ]] || mkdir mnt
mount /dev/mmcblk1p2 mnt
cp root/boot/vmlinux.uimg mnt
umount mnt

# copy the u-boot script to the script partition
mount /dev/mmcblk1p12 mnt
[[ -d mnt/u-boot ]] || mkdir mnt/u-boot
cp root/boot/boot.scr.uimg mnt/u-boot
umount mnt

# install nv-u-boot
wget -O - http://commondatastorage.googleapis.com/chromeos-localmirror/distfiles/nv_uboot-snow.kpart.bz2 | bunzip2 > nv_uboot-snow.kpart
dd if=nv_uboot-snow.kpart of=/dev/mmcblk1p1

# unmount the root partition
umount root
sync

set +x

echo '*********************************'
echo '*** NOW REBOOT INTO ARCHLINUX ***'
echo '*********************************'
