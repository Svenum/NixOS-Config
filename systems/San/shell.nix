{ ... }:

{
  programs.zsh.shellInit = (builtins.readFile ../../configs/catppuccin_latte-zsh-syntax-highlighting.zsh);
}
