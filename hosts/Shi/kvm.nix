{ pkgs, ... }:

let
  toggle_gpu = pkgs.writeShellScriptBin "toggle_gpu" ''
    echo >> /tmp/MESSAGE.txt
    echo $(date) >> /tmp/MESSAGE.txt
    echo $@ >> /tmp/MESSAGE.txt
    if [[ $1 == "Windows GPU Nix" ]]; then
      echo "DOMAIN FOUND" >> /tmp/MESSAGE.txt
      if [[ $2 == "prepare" ]]; then
        echo "PREPARE" >> /tmp/MESSAGE.txt
        /run/current-system/sw/bin/toggle_gpu vfio
      elif [[ $2 == "stopped" ]]; then
        echo "STOPPING" >> /tmp/MESSAGE.txt
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
