KERNEL_BUILD_ARCH   = arm64
KERNEL_HEADER_ARCH  = $(KERNEL_BUILD_ARCH)
KERNEL_BUILD_IMAGE  = vmlinuz.efi
KERNEL_IMAGE_PATH   = arch/$(KERNEL_BUILD_ARCH)/boot/$(KERNEL_BUILD_IMAGE)
KERNEL_INSTALL_FILE = vmlinuz
# Stock PVE arm64 GRUB. Debian Asahi already ships asahi-scripts, m1n1,
# and u-boot-asahi via asahi-platform-core; do not pull that stack here.
GRUB_RECOMMENDS     = grub-efi-arm64
