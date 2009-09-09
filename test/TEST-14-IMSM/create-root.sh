#!/bin/sh
# don't let udev and this script step on eachother's toes
for x in 61-dmraid-imsm.rules 65-md-incremental-imsm.rules 65-md-incremental.rules 64-lvm.rules 70-mdadm.rules 99-mount-rules; do
    > "/etc/udev/rules.d/$x"
done
udevadm control --reload-rules
echo y|dmraid -f isw -C Test0 --type 1 --disk "/dev/sdb /dev/sdc" 
udevadm settle
dmraid -a y
# save a partition at the beginning for future flagging purposes
sfdisk -H 255 -S 63 -L /dev/mapper/isw*Test0 <<EOF
,1
,1
,1
,
EOF
udevadm settle
dmraid -a n
udevadm settle
dmraid -a y
udevadm settle
sfdisk -l /dev/mapper/isw*Test0

mdadm --create /dev/md0 --run --auto=yes --level=5 --raid-devices=3 /dev/mapper/isw*p[123]
# wait for the array to finish initailizing, otherwise this sometimes fails
# randomly.
mdadm -W /dev/md0
lvm pvcreate -ff  -y /dev/md0
lvm vgcreate dracut /dev/md0 && \
lvm lvcreate -l 100%FREE -n root dracut && \
lvm vgchange -ay && \
mke2fs -L root /dev/dracut/root && \
mkdir -p /sysroot && \
mount /dev/dracut/root /sysroot && \
cp -a -t /sysroot /source/* && \
umount /sysroot && \
lvm lvchange -a n /dev/dracut/root && \
echo "dracut-root-block-created" >/dev/sda
poweroff -f