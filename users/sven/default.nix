{ home, pkgs, systemConfig, lib, settings, ... }:

let
  tetris = pkgs.callPackage ../../custom-nixpkgs/tetris {};
  hostname = settings.networkConfig.hostName;
  enablePlasma = if systemConfig.networking.hostName != "Ni" then true else false;
  enableNixVirt = if hostname == "Ni" || hostname == "San" || hostname == "Yon" then true else false;
  start_windows_vm = pkgs.writeShellScriptBin "start_windows_vm" ''
    virsh -c qemu:///system -d 4 start "Windows GPU Nix"
    looking-glass-client
  '';
in
{
  imports = []
    ++ lib.optional enablePlasma ./plasma.nix;

  # Add extgra packages
  home.packages = with pkgs; [
    caffeine-ng
    #tetris
    ccrypt
  ];

  # looking-glass config
  xdg.configFile."looking-glass/client.ini" = lib.mkIf (if hostname == "Yon" then true else false) {
     text = lib.generators.toINI {}{
      wayland = { fractionScale = "yes"; };
      opengl = { amdPinnedMem = "yes"; };
      input = {
        rawMouse = "yes";
        autoCapture = "yes";
        captureOnly = "yes";
        escapeKey = "KEY_F12";
      };
      spice = {
        enable = "yes";
        clipboard = "yes";
        audio = "yes";
      };
      app = { shmFile = "/dev/shm/looking-glass-sven"; };
    };
  };

  # windows.desktop
  xdg.desktopEntries.Windows = lib.mkIf (if hostname == "Yon" then true else false) {
    exec = "${start_windows_vm}/bin/start_windows_vm";
    icon = "distributor-logo-windows";
    name = "Windows";
    type = "Application";
    terminal = false;
  };
}
