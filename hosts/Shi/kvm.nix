{ ... }:

{
  virtualisation.libvirtd.hooks.qemu = {
    "Windows GPU Nix/prepare/toggle_gpu" = "/run/current-system/sw/bin/toggle_gpu vfio";
    "Windows GPU Nix/stopped/toggle_gpu" = "/run/current-system/sw/bin/toggle_gpu amd";
  };
}
