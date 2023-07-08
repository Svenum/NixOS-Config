{ ... }:

{
  programs.neovim = {
    configure = {
      customRC = (builtins.readFile ../../configs/init.vim) + "colorscheme catppuccin-latte";
    };
  };
}

