{ home, pkgs, systemConfig, lib, settings, ... }:

let
  tetris = pkgs.callPackage ../../custom-nixpkgs/tetris {};
  hostname = settings.networkConfig.hostName;
  enablePlasma = if systemConfig.networking.hostName != "Ni" then true else false;
  enableNixVirt = if hostname == "Ni" || hostname == "San" || hostname == "Yon" then true else false;
  start_win_vm = pkgs.writeShellScriptBin "start_win_vm" ''
    virsh -c qemu:///system start "Windows GPU Nix" &
    
    nc -z 127.0.0.1 5900
    nc=$?
    while [[ ! -c /dev/kvmfr0 || $nc -ne 0 ]]; do
      nc -z 127.0.0.1 5900
      nc=$?
      sleep 1
    done
    sleep 5
    looking-glass-client
    exit 0
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

  xdg.enable = true;

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
      app = { shmFile = "/dev/kvmfr0"; };
    };
  };

  # windows.desktop
  xdg.desktopEntries.Windows = lib.mkIf (if hostname == "Yon" then true else false) {
    exec = "${start_win_vm}/bin/start_win_vm";
    icon = "distributor-logo-windows";
    name = "Windows";
    type = "Application";
    terminal = false;
  };
}
