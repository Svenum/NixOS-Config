{ lib, pkgs, themeFlavour, home-manager, userAttrs, ... }:

let
  mkUserConfig = name: user: {
    home.file.".p10k.zsh".source = ./config/zsh/p10k.zsh;
    home.file.".zshrc".source = ./config/zsh/zshrc;
  };
in
{
  # Set users default shell
  users.defaultUserShell = pkgs.zsh;

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    shellInit = (builtins.readFile ./config/zsh/catppuccin_${themeFlavour}-zsh-syntax-highlighting.zsh);
    promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    ohMyZsh = {
      enable = true;
      plugins = [ "git" ];
    };
  };
  
  # Setup zshrc and p10k
  imports = [ home-manager.nixosModules.home-manager ];
  home-manager.users = lib.mapAttrs mkUserConfig userAttrs;
}
