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
      bup
      # Vim
      nerdfonts
      # Theming
      (pkgs.writeShellScriptBin "spicetify" "exec -a $0 ${spicetify-cli}/bin/spicetify-cli $@")
      betterdiscordctl
      prepare_spotify
      prepare_discord
      # GUI Tools
      kate
      kup
      libsForQt5.sddm-kcm
      # Other
      glxinfo
      vulkan-tools
      home-backup
      playerctl
    ];
  };
  # Enable partitionmanager
  programs.partition-manager.enable = true;

  # Enable fwupd
  services.fwupd.enable = true;

  # Enable Flatpak
  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
