{ lib, pkgs, settings, config, ... }:

{
  # install looking-glass-client
  environment.systemPackages = with pkgs; [
    (lib.mkIf settings.pciPassthrough.enable or false looking-glass-client)
  ];

  # Prepare kvmfr
  services.udev.extraRules = ''
    SUBSYSTEM=="kvmfr", OWNER="root", GROUP="kvm", MODE="0660"
  '';

  boot.extraModprobeConfig = ''
    options kvmfr static_size_mb=128
  '';

  virtualisation.libvirtd.qemu.verbatimConfig = ''
    namespaces = []
    cgroup_device_acl = [
      "/dev/kvmfr0", "/dev/ptmx", "/dev/null",
      "/dev/kvm"
    ]
  '';
  
  boot.extraModulePackages = with config.boot.kernelPackages; [ (kvmfr.overrideAttrs (final: prev: {
    patches = [];
  })) ];
  boot.kernelModules = [ "kvmfr" ];
}
