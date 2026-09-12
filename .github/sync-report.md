# Proxmox sync report

- Mode: `applied`
- Target: `e4e1a6d920843ae2b251f6e61b59c647440fcd5e` (`e4e1a6d`)
- Proxmox package version: `7.0.14-16`
- Previous pin: `6daa7f036b6593cd47f81d3adc07bf3a207ad842`
- Patches kept: **325**
- Patches skipped (x86/vendor filter): **65**
- Packaging files changed: **1**
- ZFS: mapped Proxmox ZFS 2.4.4 -> openzfs refs/tags/zfs-2.4.4 (f75f3256a091)

## Skipped patches
- 0008-kvm-xsave-set-mask-out-PKRU-bit-in-xfeatures-if-vCPU.patch
- 0011-Revert-UBUNTU-SAUCE-iommu-intel-disable-DMAR-for-SKL.patch
- 0018-KVM-SVM-Rename-vmcb-nested_ctl-to-vmcb-misc_ctl.patch
- 0019-KVM-nSVM-Only-copy-SVM_MISC_ENABLE_NP-from-VMCB01-s-.patch
- 0020-KVM-TDX-VMX-rework-EPT_VIOLATION_EXEC_FOR_RING3_LIN-.patch
- 0021-KVM-x86-mmu-remove-SPTE_PERM_MASK.patch
- 0022-KVM-x86-mmu-free-up-bit-10-of-PTEs-in-preparation-fo.patch
- 0023-KVM-x86-mmu-shuffle-high-bits-of-SPTEs-in-preparatio.patch
- 0024-KVM-x86-mmu-remove-SPTE_EPT_.patch
- 0025-KVM-x86-mmu-merge-make_spte_-non-executable.patch
- 0026-KVM-x86-mmu-rename-and-clarify-BYTE_MASK.patch
- 0027-KVM-x86-mmu-separate-more-EPT-non-EPT-permission_fau.patch
- 0028-KVM-x86-mmu-introduce-ACC_READ_MASK.patch
- 0029-KVM-x86-mmu-pass-PFERR_GUEST_PAGE-FINAL_MASK-to-kvm_.patch
- 0030-KVM-x86-mmu-pass-pte_access-for-final-nGPA-GPA-walk.patch
- 0031-KVM-x86-make-translate_nested_gpa-vendor-specific.patch
- 0032-KVM-x86-mmu-split-XS-XU-bits-for-EPT.patch
- 0033-KVM-x86-mmu-move-cr4_smep-to-base-role.patch
- 0034-KVM-VMX-enable-use-of-MBEC.patch
- 0035-KVM-nVMX-pass-advanced-EPT-violation-vmexit-info-to-.patch
- 0036-KVM-nVMX-pass-PFERR_USER_MASK-to-MMU-on-EPT-violatio.patch
- 0037-KVM-x86-mmu-add-support-for-MBEC-to-EPT-page-table-w.patch
- 0038-KVM-nVMX-advertise-MBEC-to-nested-guests.patch
- 0039-KVM-nVMX-allow-MBEC-with-EVMCS.patch
- 0040-KVM-x86-mmu-propagate-access-mask-from-root-pages-do.patch
- 0041-KVM-x86-mmu-introduce-cpu_role-bit-for-availability-.patch
- 0042-KVM-SVM-add-GMET-bit-definitions.patch
- 0043-KVM-x86-mmu-hard-code-more-bits-in-kvm_init_shadow_n.patch
- 0044-KVM-x86-mmu-add-support-for-GMET-to-NPT-page-table-w.patch
- 0045-KVM-SVM-enable-GMET-and-set-it-in-MMU-role.patch
- 0046-KVM-SVM-work-around-errata-1218.patch
- 0047-KVM-nSVM-enable-GMET-for-guests.patch
- 0050-KVM-x86-Check-for-invalid-obsolete-root-after-making.patch
- 0051-KVM-nVMX-Hide-shadow-VMCS-right-after-VMCLEAR.patch
- 0060-x86-bugs-Make-Safe-RET-robust-against-interrupt-inje.patch
- 0061-serial-8250_mid-Fix-NULL-function-pointer-dereferenc.patch
- 0062-drm-amdgpu-fix-check-in-amdgpu_hmm_invalidate_gfx.patch
- 0063-KVM-nVMX-Put-vmcs12-pages-if-nested-VM-Enter-fails-d.patch
- 0065-KVM-x86-mmu-Fix-use-after-free-on-vendor-module-relo.patch
- 0066-KVM-SVM-Bump-asid_generation-on-CPU-online-to-avoid-.patch
- 0072-iommu-intel-Fix-out-of-bounds-memset-in-dmar_latency.patch
- 0073-iommu-amd-Bound-the-early-ACPI-HID-map.patch
- 0074-iommu-amd-Wait-for-completion-instead-of-returning-e.patch
- 0076-iommu-amd-Fix-IRQ-unsafe-locking-in-gdom-allocation.patch
- 0099-net-txgbe-fix-FDIR-filter-leak-on-remove.patch
- 0100-bnxt_en-Handle-partially-initialized-auxiliary-devic.patch
- 0123-KVM-x86-Nullify-irqfd-producer-if-updating-IRTE-for-.patch
- 0124-KVM-x86-Ignore-pending-PV-EOI-if-the-vCPU-has-since-.patch
- 0125-KVM-TDX-Reject-concurrent-change-to-CPUID-entry-coun.patch
- 0126-KVM-SEV-Do-not-allow-intra-host-migration-mirroring-.patch
- 0127-KVM-nVMX-Move-vTPR-vs.-TPR-Threshold-consistency-che.patch
- 0188-KVM-SVM-Update-x2APIC-MSR-intercepts-if-AVIC-is-inhi.patch
- 0189-KVM-x86-Cancel-delayed-I-O-APIC-EOI-handling-before-.patch
- 0224-ipv6-ndisc-fix-NULL-deref-in-accept_untracked_na.patch
- 0265-KVM-SVM-Serialize-accesses-to-the-owner-and-mirror-l.patch
- 0313-scsi-megaraid_sas-Limit-NVMe-request-size-to-the-PRP.patch
- 0352-ice-reject-out-of-range-ptype-in-ice_parser_profile_.patch
- 0357-vmxnet3-fix-BUG_ON-in-vmxnet3_get_hdr_len-for-Geneve.patch
- 0358-qede-fix-off-by-one-in-BD-ring-consumption-on-build_.patch
- 0359-qede-sync-udp_tunnel-ports-outside-qede_lock-in-the-.patch
- 0360-net-mlx5-Fix-MCIA-register-buffer-overflow-on-32-dwo.patch
- 0361-ice-fix-PTP-Call-Trace-during-PTP-release.patch
- 0362-ixgbe-do-not-configure-xps-for-XDP-queues.patch
- 0373-crypto-ccp-Fix-snp_filter_reserved_mem_regions-off-b.patch
- 0386-KVM-x86-mmu-Check-write-tracking-in-all-address-spac.patch

## Packaging files to refresh
- debian/proxmox_prevent_autoload.conf

## Intentional Asahi overlay (never overwritten by this sync)

- `submodules/asahi-kernel` (Ubuntu Asahi) instead of Ubuntu generic
- `Makefile` / `debian/rules` arm64 + cross-build + Apple DTB bits
- `debian/rules.d/config-arm64.opts` Asahi flavour overrides
- Package `KERNEL_*` / `KREL` stay Asahi-based; Proxmox version is recorded in the pin file only
