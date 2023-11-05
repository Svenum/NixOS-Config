{ pkgs, flatpak, ... }:

let
  prepare_spotify = pkgs.writeShellScriptBin "prepare_spotify" (builtins.readFile ../../scripts/prepare_spotify.sh);
  prepare_discord = pkgs.writeShellScriptBin "prepare_discord" (builtins.readFile ../../scripts/prepare_discord.sh);
  home-backup = pkgs.writeShellScriptBin "home-backup" (builtins.readFile ../../scripts/home-backup.sh);
in
{
  system.autoUpgrade = {
    enable = true;
    dates = "daily";
  };

  nixpkgs.config.allowUnfree = true;
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
      # Theming
      (pkgs.writeShellScriptBin "spicetify" "exec -a $0 ${spicetify-cli}/bin/spicetify-cli $@")
      betterdiscordctl
      prepare_spotify
      prepare_discord
      home-backup
      playerctl
    ];
  };

  # Enable fwupd
  services.fwupd.enable = true;
}
