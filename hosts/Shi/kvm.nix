{ pkgs, ... }:

let
  toggle_gpu = pkgs.writeShellScriptBin "toggle_gpu" ''
    if [[ $1 == "Windows GPU Nix" ]]; then
      if [[ $2 == "prepare" ]]; then
        /run/current-system/sw/bin/toggle_gpu vfio
      elif [[ $2 == "stopped" ]]; then
        ${pkgs.busybox}/bin/sleep 10
        /run/current-system/sw/bin/toggle_gpu amd
      fi
    fi
  '';
in
{
  virtualisation.libvirtd.hooks.qemu = {
    "toggle_gpu" = "${toggle_gpu}/bin/toggle_gpu";
  };
}
