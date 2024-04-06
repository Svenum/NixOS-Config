{ lib, pkgs, settings, ... }:

let
  mkShimMapping = name: user: {
    "/dev/shm/looking-glass-${name}" = lib.mkIf user.isKvmUser or false {
      f = {
        group = "kvm";
        user = name;
        mode = "0660";
      };
    };
  };
in
{
  # disable terminal in looking-glass.desktop
  nixpkgs.overlays = [
    (
      final: prev: {
        looking-glass-client = prev.looking-glass-client // {
          desktopItem = prev.looking-glass-client.desktopItem // {
            terminal = lib.mkForce false;
          };
        };
      }
    )
  ];

  # install looking-glass-client
  environment.systemPackages = with pkgs; [
    (lib.mkIf settings.pciPassthrough.enable or false looking-glass-client)
  ];

  # Prepare Shim permissions
  systemd.tmpfiles.settings = lib.mkIf settings.pciPassthrough.enable or false (builtins.mapAttrs mkShimMapping settings.userAttrs);

}
