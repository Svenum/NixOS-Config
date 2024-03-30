{ pkgs, lib, settings, nixVirt, system, ... }:

let
  mkUserConfig = name: user: {
    dconf.settings = lib.mkIf user.isKvmUser or false {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = ["qemu:///system" "qemu:///session"];
        uris = ["qemu:///system" "qemu:///session"];
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
    libvirtd.enable = true;
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
    nixVirt.packages.x86_64-linux.default
  ];
}
