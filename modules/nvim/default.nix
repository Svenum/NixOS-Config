{ pkgs, config, settings, ... }:

{
  # Install and Configure nvim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    configure = {
      customRC = (builtins.readFile ./config/init.vim) + "colorscheme catppuccin-${settings.theme.flavour}";
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
          # Markdown Preview
          markdown-preview-nvim
        ];
      };
    };
  };

  # Install dependencis
  environment.systemPackages = with pkgs; [
    nerdfonts
  ];
}
