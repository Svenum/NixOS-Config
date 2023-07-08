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
        " NNN
        autocmd VimEnter * call nnn#pick()
        lua << EOF
          require("nnn").setup({
            replace_netrw = nil,
            action = {
              ["<S-s>"] = "split",
              ["<S-v>"] = "vsplit",
            },
          })
        EOF
        "autocmd VimEnter * NnnExplorer
        if @% != "" && @% != "." && @% != "./"
                autocmd VimEnter * execute  "normal \<C-w>\<right>" | stopinsert
        endif
        
        autocmd BufWinLeave,WinLeave term://* startinsert
        nnoremap <C-n> :NnnPicker<CR>
        inoremap <C-n> <Esc> :NnnPicker<CR>
        tnoremap <C-n> <C-\><C-n> :NnnPicker<CR>

        " ToggleTerm
        lua << EOF
          require('smart-term-esc').setup({
              key = '<Esc>',
              except = {'nvim', 'fzf'}
          })
      
          require("toggleterm").setup{
              direction = 'vertical',
              shell = '/bin/zsh',
              size = vim.o.columns * 0.2
          }
        EOF
      
        nnoremap <C-Space> :ToggleTerm<CR><CR>
        tnoremap <C-Space> <C-\><C-n> :ToggleTerm<CR>

        " Airline
        let g:airline_theme='luna'

        " Rainbow
        let g:rainbow_active=1

        " Coc
        set nobackup
        set nowritebackup
        set updatetime=300
        set signcolumn=yes
        function! CheckBackspace() abort
          let col = col('.') - 1
          return !col || getline('.')[col -1] =~# '\s'
        endfunction

        " Set Alt+Enter
        inoremap <silent><expr> <A-CR> coc#pum#visible() ? coc#pum#confirm()
                  \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

        " Cursor
        set tabstop=2
        set shiftwidth=2
        set expandtab
          
        " Add CTRL+D
        nmap <expr> <silent> <C-d> <SID>select_current_word()
        function! s:select_current_word()
          if !get(b:, 'coc_cursors_activated', 0)
            return "\<Plug>(coc-cursors-word)"
          endif
          return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
        endfunc

        " Shortcuts
        nnoremap <silent> <C-Right> :tabnext<CR>
        nnoremap <silent> <C-Left> :tabprevious<CR>
        nnoremap <silent> <C-Down> :tabclose<CR> 
        tnoremap <silent> <C-Right> <C-\><C-n> :tabnext<CR>
        tnoremap <silent> <C-Left> <C-\><C-n> :tabprevious<CR>
        tnoremap <silent> <C-Down> <C-\><C-n> :tabclose<CR> 
        
        nnoremap <silent> <C-f> <Esc> /
        
        nnoremap <silent> <C-S-Right> :vert res +5 <CR>
        nnoremap <silent> <C-S-Left> :vert res -5 <CR>
        nnoremap <silent> <C-S-Up> :res +5 <CR>
        nnoremap <silent> <C-S-Down> :res -5 <CR>
        tnoremap <silent> <C-S-Right> <C-\><C-n> :vert res +5 <CR> i
        tnoremap <silent> <C-S-Left> <C-\><C-n> :vert res -5 <CR> i
        tnoremap <silent> <C-S-Up> <C-\><C-n> :res +5 <CR> i
        tnoremap <silent> <C-S-Down> <C-\><C-n> :res -5 <CR> i
        
        nnoremap <C-c> :quitall<CR>
        
        nnoremap <C-q> :q<CR>
        inoremap <C-q> <Esc>:q<CR>
        tnoremap <C-q> <C-\><C-n>:q<CR>
        
        nnoremap <A-w> :w<CR>
        inoremap <A-w> <Esc>:w<CR>
        
        nnoremap <silent> <A-Down> :split<CR>
        nnoremap <silent> <A-Right> :vsplit<CR>
        
        inoremap <C-h> <C-w>
        
        " Functions
        if has('nvim')
            augroup terminal_setup | au!
                autocmd TermOpen * nnoremap <buffer><LeftRelease> <LeftRelease>i
            augroup end
        endif
        
        autocmd BufWinEnter,WinEnter term://* startinsert
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
  };
}
