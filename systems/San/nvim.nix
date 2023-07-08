{ pkgs, ... }:

{
  programs.neovim = {
    configure = {
      customRC = ''
        " Theme
          colorscheme catppuccin-latte
      '';
    };
  };
}

