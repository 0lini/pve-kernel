# Rebuild the Asahi kernel snapshot

This flavour does **not** submodule Launchpad `linux-asahi-arm` or the
Ubuntu Asahi PPA. Those stay at Linux 6.17.12 (`Ubuntu-asahi-arm-6.17.0-1001.1`).
Proxmox `trixie-6.17` pins Ubuntu HWE **6.17.13**. The snapshot is a rebuild
of the same-series Ubuntu kernel plus the last 6.17 Asahi patchset, then
Ubuntu Asahi `debian.asahi-arm` packaging (which `pve-kernel` **strips** at
prepare). Method: [Ubuntu Asahi kernel packaging](https://github.com/UbuntuAsahi/ubuntu-asahi/wiki/Kernel-packaging).

Current pin (also in `debian.asahi-arm/ubuntu-asahi` on the snapshot):

```
Ubuntu-hwe-6.17-6.17.0-42.42 = v6.17.13 + asahi-6.17.12-1
```

Git: this repo, branch `cursor/asahi-kernel-6.17-0189`, commit `a15654b`.
Path in pve-kernel: `submodules/ubuntu-kernel`. Do not open a packaging PR
for that branch.

PVE patches (`patches/kernel/*.patch`) are **not** part of this rebuild.
`make` applies them onto a copy after the snapshot is cloned.

## What this snapshot is

| Piece | Source |
| --- | --- |
| Ubuntu kernel | `Ubuntu-hwe-6.17-6.17.0-42.42` (same tag Proxmox uses; Linux 6.17.13) |
| Asahi code | `git diff v6.17.12 asahi-6.17.12-1` from https://github.com/AsahiLinux/linux |
| `debian.asahi-arm` + `debian/debian.env` | copied from Launchpad `linux-asahi-arm` tag `Ubuntu-asahi-arm-6.17.0-1001.1`, `DEBIAN=debian.asahi-arm` |
| Changelog on the snapshot | `linux-asahi-arm (6.17.0-1003.3)` — rebuild note only; not the PVE `.deb` version |

## How 6.17.13 + asahi-6.17.12-1 was made

Wiki step 1 is “Ubuntu kernel of the **same major.minor**”. For PVE that
Ubuntu kernel is HWE 42, not Questing 6.17.0-41.41 (that tree broke PVE
rtmutex patch 0037).

```bash
# 1. Ubuntu pin (match pve-kernel trixie-6.17)
git clone --reference-if-able <local-mirror> \
  https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux-hwe-6.17 \
  linux-hwe-6.17
cd linux-hwe-6.17
git checkout Ubuntu-hwe-6.17-6.17.0-42.42

# 2. Asahi patchset against the version it was tagged on (6.17.12, not 6.17.13)
git clone https://github.com/AsahiLinux/linux.git ../asahi-linux
git -C ../asahi-linux diff v6.17.12 asahi-6.17.12-1 > ../asahi-6.17.12-1.patch

# 3. Apply onto 6.17.13. Plain git apply fails (stable drift). Use 3-way:
git apply --3way ../asahi-6.17.12-1.patch || true
# Remaining conflicts: merge-file (base=v6.17.12, ours=HWE 42, theirs=asahi).
# One remaining conflict: drivers/usb/dwc3 host_exit vs
# role_switch_reset_quirk — keep the Asahi quirk.

# 4. Wiki: copy debian.asahi-arm from Ubuntu Asahi of the same series
git clone --branch Ubuntu-asahi-arm-6.17.0-1001.1 \
  https://git.launchpad.net/~ubuntu-asahi/+git/linux-asahi-arm \
  ../linux-asahi-arm-1001.1
rm -rf debian.asahi-arm
cp -a ../linux-asahi-arm-1001.1/debian.asahi-arm .
echo 'DEBIAN=debian.asahi-arm' > debian/debian.env

# 5. Record the pin
# debian.asahi-arm/ubuntu-asahi:
#   Ubuntu-hwe-6.17-6.17.0-42.42 = v6.17.13 + asahi-6.17.12-1

# 6. Snapshot (orphan or dedicated kernel repo). Then in pve-kernel:
#    git submodule set-url submodules/ubuntu-kernel <that-repo>
#    git submodule update --remote
#    bump debian/changelog + Makefile KREL if ABI changes
```

`pve-kernel` never builds Ubuntu `.deb`s. After submodule update, `make deb`
copies the tree, exports `--flavour asahi-arm`, strips `debian*`, applies
`patches/kernel`.

## Next time (new Asahi or new PVE Ubuntu pin)

1. Read Proxmox `trixie-6.17` (or the series you track): Ubuntu tag and
   `KERNEL_PATCHLEVEL`.
2. Read https://github.com/AsahiLinux/linux/tags for `asahi-<same-maj.min>.*`.
   If Asahi has left 6.17 for 6.18, take an Ubuntu 6.18 of that series
   (wiki `git rebase -X ours` onto that Ubuntu branch) and copy a current
   `debian.asahi-arm`.
3. Prefer `git diff vX.Y.Z asahi-X.Y.Z-N` then `--3way` onto the Ubuntu
   tag if the Asahi tag is not the same patchlevel as Ubuntu.
4. Copy `debian.asahi-arm` from the latest Ubuntu Asahi of that series;
   keep `debian/debian.env` as `DEBIAN=debian.asahi-arm`.
5. Confirm PVE `patches/kernel` still apply (`make ubuntu-kernel.prepared`).
   Re-check rtmutex 0037 if the Ubuntu spinlock/waiter layout changed.
6. Push a new snapshot, point `.gitmodules` + gitlink, set `KERNEL_PATCHLEVEL`
   / `KREL` / `debian/changelog` in pve-kernel.

Do not point the submodule at the PPA. Do not keep Ubuntu `debian/` in the
PVE image (prepare deletes it). Overlay automation that watches Asahi tags
is a separate tree; this file is the manual procedure.
