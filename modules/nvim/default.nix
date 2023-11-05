{ pkgs, config, themeFlavour, ... }:

{
  # Install and Configure nvim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    configure = {
      customRC = (builtins.readFile ../../configs/init.vim) + "colorscheme catppuccin-${themeFlavour}";
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
          coc-vimlsp coc-vimtex coc-lua
          vim-nix 
          # Explorer
          nvim-web-devicons
          nvim-tree-lua
          # Syntax highlighter
          rainbow
          # IDE
          auto-pairs
          surround-nvim
          # Theme
          catppuccin-nvim
          # Terminal
          tmux-nvim
          # Git
          vim-gitgutter
        ];
      };
    };
  };
}
