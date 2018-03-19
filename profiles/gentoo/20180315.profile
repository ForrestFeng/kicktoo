# Skip it, manually create as the script has issue to create -uM not supported by sfdick
part sda 1 83 100M
part sda 2 82 2048M
part sda 3 83 +

format /dev/sda1 ext2
format /dev/sda2 swap
format /dev/sda3 ext4


mountfs /dev/sda1 ext2 /boot
mountfs /dev/sda2 swap
mountfs /dev/sda3 ext4 / noatime

# retrieve latest autobuild stage version for stage_uri
# [ "${arch}" == "x86" ]   && stage_latest $(uname -m)

# The file:// path must be a absolute path
[ "${arch}" == "amd64" ] && stage_uri file:///root/usb/Gentoo/stage3-amd64-20180315T214502Z.tar.xz
tree_type   snapshot   http://mirrors.163.com/gentoo/releases/snapshots/current/portage-20180315.tar.bz2
                       #  http://distfiles.gentoo.org/snapshots/portage-latest.tar.bz2

# get kernel dotconfig from the official running kernel
#cat /proc/config.gz | gzip -d > /dotconfig
#kernel_config_file       /dotconfig
kernel_sources	         gentoo-sources
initramfs_builder               
genkernel_kernel_opts    --loglevel=5
genkernel_initramfs_opts --loglevel=5

grub2_install /dev/sda

timezone                UTC
rootpw                  a
bootloader              grub
keymap	                us # be-latin1 fr
hostname                gentoo
extra_packages          dhcpcd # syslog-ng vim openssh

rcadd                   sshd       default
#rcadd                   syslog-ng  default
