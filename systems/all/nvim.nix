{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    configure = {
      customRC = ''
        " Airline
        let g:airline_theme='luna'

      '';
      packages.nix = {
        start = with pkgs.vimPlugins; [
          # Plugins
          vim-plug
          # CoC
          coc-sh coc-git coc-css coc-yaml
          coc-nvim coc-json coc-html coc-tslint
          coc-eslint coc-docker coc-tabnine
          coc-tsserver coc-prettier coc-highlight
          coc-markdownlint coc-spell-checker
          vim-nix
          # Explorer
          nnn-vim
          # Syntax highlighter
          rainbow
          # IDE
          auto-pairs
          surround-nvim
          # Theme
          #papercolor-theme
          catppuccin-nvim
          # Terminal
          toggleterm-nvim
        ];
      };
    };
  #plugins: = [];
  };
}
