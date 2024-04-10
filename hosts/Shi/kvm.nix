{ ... }:

{
  virtualisation.libvirtd.hooks.qemu = {
    "toggle_gpu" = "/run/current-system/sw/bin/toggle_gpu vfio";
    #toggle_gpu" = "/run/current-system/sw/bin/toggle_gpu amd";
  };
}
