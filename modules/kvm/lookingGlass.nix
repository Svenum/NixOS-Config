{ lib, pkgs, settings, config, ... }:

#let
#  mkShimMapping = name: user: {
#    "/dev/shm/looking-glass-${name}" = lib.mkIf user.isKvmUser or false {
#      f = {
#        group = "kvm";
#        user = name;
#        mode = "0660";
#      };
#    };
#  };
#in
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
  
  boot.extraModulePackages = with config.boot.kernelPackages; [ kvmfr ];
  boot.kernelModules = [ "kvmfr" ];

  # Prepare Shim permissions
  #systemd.tmpfiles.settings = lib.mkIf settings.pciPassthrough.enable or false (builtins.mapAttrs mkShimMapping settings.userAttrs);

}
