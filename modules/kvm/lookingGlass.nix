{ lib, pkgs, pkgs-stable, settings, config, ... }:

{
  # install looking-glass-client
  environment.systemPackages = with pkgs; [
    (lib.mkIf settings.pciPassthrough.enable or false pkgs-stable.looking-glass-client)
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
  
  boot.extraModulePackages = [ pkgs-stable.linuxPackages_latest.kvmfr ];
  boot.kernelModules = [ "kvmfr" ];
}
