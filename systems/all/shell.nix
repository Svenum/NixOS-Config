{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
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
