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

## Verified (native Debian Asahi)

- `make deb` produced `proxmox-kernel-6.17.13-1-asahi-pve_6.17.13-1_arm64.deb`
  (and headers/tools/meta/signed-template). First arm64 ABI/fwlist checks
  skipped as designed. `lintian` on linux-tools reported only
  `groff-message` on `perf-bench`. `dpkg-genchanges` warns `6.17.13-1` is
  earlier than stock changelog `6.17.13-21` (debian revision); fine on a
  machine that never had a PVE 6.17 kernel.
- `apt install` of the flavour image (not the series meta, which Depends
  on `pve-firmware`): initramfs built, GRUB found this image alongside
  Debian `6.17.9+deb13.2-asahi`, `zz-update-m1n1` wrote ESP
  `/m1n1/boot.bin`. `/usr/lib/linux-image-6.17.13-1-asahi-pve/apple`
  lists Apple DTBs (`t8103`, `t8112`, `t600x`, `t602x`, …).
- Hardware boot: `uname -r` reports `6.17.13-1-asahi-pve`. Second reboot
  still came up on this ABI (GRUB default + m1n1 persist).
- aarch64 KVM guest on this host works. Nested virt is **not** available
  on this M2: `/dev/kvm` and VHE KVM init succeed, but CPU Features have
  no `nv`/`nv2` (implementer `0x61`). The `kvm: nv: … trap handlers`
  lines are KVM registering nested-emulation tables, not FEAT_NV. No
  `nested` kvm module parameter. KVM also reports 36-bit reduced IPA,
  non-architectural VGIC, and GICv3 sysreg trapping.

- On this ABI (M2 mini): `end0` up on `vmbr0`, `wlp1s0f0` present (DOWN),
  USB root hubs, modules `asahi`, `brcmfmac`, `nvme_apple`, `tg3`.
  `apple-dcp` modeset 3840x2160@60. brcmfmac firmware name fallbacks
  then loaded BCM4388. Missing `tigon/tg357766.bin` (no `pve-firmware`);
  link still 1 Gbps, EEE off. DT usb-pd/phy cycles are normal.
- Debian `6.17.9+deb13.2-asahi` one-shot via `grub-reboot`: same
  `lsmod`/`ip link`/`lsusb` set (`asahi`, `brcmfmac`, `nvme_apple`,
  `tg3`, `end0`/`vmbr0` up, `wlp1s0f0` DOWN, USB root hubs).
  `journalctl -k` on that boot was empty without `adm`/`systemd-journal`.
- `macsmc_hwmon` is present (`CONFIG_SENSORS_MACSMC_HWMON=m`). Power
  sysfs is `hwmon1` on this ABI (not Debian's `hwmon3`): Total System
  Power / AC Input / 3.8 V Rail.

- OpenZFS 2.4.2-pve1 on 16K (`PAGE_SIZE=16384`): `modprobe zfs` loaded;
  file-backed pool `test` ONLINE, scrub repaired 0B with 0 errors.

## Not completed here

1. **ABI file** — no `abi-prev-*-arm64` yet. First headers package skips
   the check; then `make ARCH=arm64 abiupdate`.
2. **Firmware list** — first modules install skips the check. Commit
   `fwlist-previous-arm64` after that if later builds should diff it.
   Apple GPU firmware stays on Debian Asahi (`linux-firmware-asahi`);
   this flavour does not ship `pve-firmware`.
3. **Custom apt repo** — `make deb` now emits `proxmox-default-kernel` and
   `proxmox-default-headers` for `apt install proxmox-ve`. Publish those
   plus the flavour image/headers and pin the origin; not verified against
   a live `proxmox-ve` install from that repo.
