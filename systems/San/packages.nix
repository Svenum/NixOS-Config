{ pkgs, ... }:

let
  toggle_gpu = pkgs.writeShellScriptBin "toggle_gpu" (builtins.readFile ../../scripts/san_toggle_gpu.sh);
in
{
  environment = {
    systemPackages = with pkgs; [
      toggle_gpu
      rsync
      nvtop
      powertop
    ];
  };
  # Gamemode
  programs.gamemode.enable = true;
   
  # KDEConnect
  programs.kdeconnect.enable = true;

  # Tuxedo Control Center
  hardware.tuxedo-control-center.enable = true;
}
