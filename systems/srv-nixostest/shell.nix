{ ... }:

{
  programs.zsh.shellInit = (builtins.readFile ../../configs/catppuccin_mocha-zsh-syntax-highlighting.zsh);
}
