{ pkgs, themeFlavour, ... }:

{
  # Set users default shell
  users.defaultUserShell = pkgs.zsh;

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    shellInit = (builtins.readFile ../../configs/catppuccin_${themeFlavour}-zsh-syntax-highlighting.zsh);
    promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    ohMyZsh = {
      enable = true;
      plugins = [ "git" ];
    };
  };
}
