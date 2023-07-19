{ ... }:

{
  programs.zsh.shellInit = (builtin.readFile ../../configs/catppuccin_latte-zsh-syntax-highlighting.zsh);
}
