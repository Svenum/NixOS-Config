{ pkgs, ... }:

let
  load_amd = pkgs.writeShellScriptBin "load_amd" ''
    #/run/current-system/sw/bin/toggle_gpu amd
    echo $@ > /tmp/MESSAGE.txt
  '';

  load_vfio = pkgs.writeShellScriptBin "load_vfio" ''
    #/run/current-system/sw/bin/toggle_gpu vfio
  '';
in
{
  virtualisation.libvirtd.hooks.daemon = {
    "load_vfio" = load_vfio;
    #"Windows GPU Nix/stopped/end/load_amd" = load_amd;
  };
}
