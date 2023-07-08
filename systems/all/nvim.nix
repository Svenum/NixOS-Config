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

        " Coc
        set nobackup
        set nowriteback
        set updatetime=300
        set signcolumn=yes
        function! CheckBackspace() abort
          let col = col('.') - 1
          return !col || getline('.')[col -1] =~# '\s'
        endfunction

        inoremap <silent><expr> <A-CR> coc#pum#visible() ? coc#pum#confirm()
                  \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

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
