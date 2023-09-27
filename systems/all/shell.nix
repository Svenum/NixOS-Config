{ pkgs, config, ... }:

{
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    shellInit = (builtins.readFile ../../configs/catppuccin_${config.systemConfig.theme.flavour}-zsh-syntax-highlighting.zsh);
    promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    ohMyZsh = {
      enable = true;
      plugins = [ "git" ];
    };
  };

  environment.shellInit = ''
      su() {
        if [[ $1 != "" ]]; then
          ${pkgs.su}/bin/su $@
        else
          sudo -s
        fi
      }
    '';
}
