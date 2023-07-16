{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      solaar
      rsync
      timeshift
    ];
  };

  # Gamemode
  programs.gamemode.enable = true;
}
