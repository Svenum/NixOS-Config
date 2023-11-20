{ pkgs, ... }:

let 
  backup = pkgs.writeShellScriptBin "backup" (builtins.readFile ./script/backup.sh);
in
{
  environment = {
    systemPackages = with pkgs; [
      # CLI Packages
      git
      wget
      tree
      unzip
      pciutils
      clinfo
      killall
      neofetch
      cifs-utils
      btop
      dig
      rclone
      # Scripts
      backup
    ];
  };
}
