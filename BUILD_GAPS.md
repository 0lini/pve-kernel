# Remaining build gaps (Asahi arm64 6.17)

First Asahi arm64 flavour of pve-kernel 6.17. The PPA is not a submodule
source.

Pinned:

- git: this repo branch `cursor/asahi-kernel-6.17-0189`
  (Ubuntu-hwe-6.17-6.17.0-42.42 / Linux 6.17.13 + `asahi-6.17.12-1`)
- rebuilt from Launchpad `Ubuntu-asahi-arm-6.17.0-1001.1` using
  https://github.com/UbuntuAsahi/ubuntu-asahi/wiki/Kernel-packaging
- path: `submodules/ubuntu-kernel` (unchanged)
- package ABI: `6.17.13-1-asahi-pve` (arm64 only)

Packaging is native arm64 (`make deb` on Apple silicon).

## Verified (prepare)

- `ubuntu-kernel.prepared` on amd64 (`ARCH=arm64`) and on native Debian
  Asahi: `debian.asahi-arm` flavour `asahi-arm` export and all 45
  `patches/kernel/*.patch` apply. Config has `CONFIG_DRM_ASAHI=m`,
  `CONFIG_ARM64_16K_PAGES=y`, `CONFIG_RUST=y`, `CONFIG_ARCH_APPLE=y`,
  `CONFIG_EFI_ZBOOT=y`. `CONFIG_GENDWARFKSYMS` is unset in annotations
  (enabled from `config-common.opts`).
- `debian.prepared`: scripts for `6.17.13-1-asahi-pve`. On an arm64 host,
  `Recommends: grub-efi-arm64`.
- Native Asahi `pkg-zfs.prepared` needs host `dh-python` (and
  `sphinx-common`) *before* `mk-build-deps` on the generated control.
  Passing a missing `proxmox-kernel-*/debian/control` path makes
  `mk-build-deps` look up a source package and demand `deb-src` URIs.

## Not completed here

1. **Native `make deb` on Apple silicon** — full package build and
   hardware boot of this ABI still outstanding.
2. **ABI file** — no `abi-prev-*-arm64` yet. First headers package skips
   the check; then `make ARCH=arm64 abiupdate`.
3. **Firmware list** — first modules install skips the check. Commit
   `fwlist-previous-arm64` after that if later builds should diff it.
   Apple GPU firmware stays on Debian Asahi (`linux-firmware-asahi`);
   this flavour does not ship `pve-firmware`.
4. **OpenZFS on 16K hardware** — untested on Apple silicon 16K pages.
