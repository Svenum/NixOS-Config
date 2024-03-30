{ pkgs, lib, settings, nixVirt, system, ... }:

let
  mkUserConfig = name: user: {
    dconf.settings = lib.mkIf user.isKvmUser or false {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = ["qemu:///system"];
        uris = ["qemu:///system"];
      };
    };
  };

  mkUser = name: user: {
    extraGroups = lib.mkIf user.isKvmUser or false [
      "kvm"
      "libvirtd"
    ];
  };
in
{
  # Enable spiceUSBRedirection
  virtualisation = {
    spiceUSBRedirection.enable = true;
  };
  programs.virt-manager.enable = true;

  # Add user to groups
  users.users = lib.mapAttrs mkUser settings.userAttrs;

  # Connect to QEMU
  home-manager.users = lib.mapAttrs mkUserConfig settings.userAttrs;

  # Import nixVirt
  imports = [ nixVirt.nixosModules.default ];

  environment.systemPackages = with pkgs; [
    nixVirt.packages.x86_64.default
  ];

  virtualisation.libvirt = {
    enable = true;
  };
}
