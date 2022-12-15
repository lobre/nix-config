{ config, pkgs, ... }:

{
  # Colorscheme
  xdg.configFile."nvim/colors/ansi.vim".source = ./ansi.vim;

  programs.neovim = {
    enable = true;
    vimAlias = true;

    extraConfig = ''
      " Use custom minimal ansi scheme
      colorscheme ansi

      " General options
      set cmdheight=0                " Number of lines reserved to commands
      set completeopt-=preview       " Don’t show preview on completion
      set grepprg=internal           " Use vimgrep for grep
      set inccommand=nosplit         " Buffer live preview on substitute changes
      set laststatus=3               " Only show statusline at the bottom
      set noruler                    " Disable ruler
      set scrollback=50000           " Lines to keep in terminal buffer
      set shortmess+=I               " Disable intro page
      set title                      " Set terminal title
      set wildignore=ctags,.git/     " Ignore files and dirs in searches
      set wildmode=longest:full,full " Completion menu

      " Language specific indentation settings
      set shiftwidth=4 tabstop=4 expandtab
      autocmd FileType go setlocal shiftwidth=8 tabstop=8 noexpandtab
      autocmd FileType html,json,nix,xml setlocal shiftwidth=2 tabstop=2

      " Save with sudo
      command! W w !sudo tee % > /dev/null

      " Git blame current line
      command! Blame execute 'split | terminal git blame % -L ' . line('.') . ',+1'

      " Find file in git index
      command! -nargs=1 -bang -complete=custom,s:git_files F edit<bang> <args>
      function! s:git_files(A, L, P)
        return system("git ls-files --recurse-submodules 2>/dev/null")
      endfunction

      " Search and replace mappings
      nnoremap <c-p> :F<space>
      nnoremap <c-f> :sil grep // `git ls-files --recurse-submodules` \| cw<home><s-right><s-right><right><right>

      " Alternate buffer
      nnoremap ga <c-^>

      " Exit insert for terminal
      tnoremap <esc> <c-\><c-n>

      " Filter quicklist with the included cfilter plugin
      packadd cfilter

      " Explorer settings
      let g:netrw_banner = 0           " Don’t show top banner
      let g:netrw_localrmdir = 'rm -r' " Let delete a non-empty directory

      " Trigger autoread when files changes on disk
      autocmd FocusGained,BufEnter * silent! checktime
      autocmd CursorHold,CursorHoldI * silent! checktime
      autocmd CursorMoved,CursorMovedI * silent! checktime " this one could be slow

      " Try to include local config
      if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
      endif
    '';

    extraPackages = with pkgs; [
      elmPackages.elm-language-server
      gopls
      rnix-lsp
      zls
    ];

    plugins = with pkgs.vimPlugins; [
      # Syntax for zig and nix were added recently in vim and neovim
      # https://github.com/neovim/neovim/commit/35767769036671d5ce562f53cae574f9c66e4bb2
      # Waiting for the next version of neovim to have it in nixpkgs because only in master so far.
      vim-nix
      {
        plugin = zig-vim;
        config = "let g:zig_fmt_autosave = 0";
      }

      {
        plugin = nvim-lspconfig;
        config = ''
          lua <<EOF
          local on_attach = function(client, bufnr)
            vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

            if client.server_capabilities.documentFormattingProvider then
              vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                callback = function()
                  vim.lsp.buf.format({ bufnr = bufnr })
                end,
              })
            end

            local bufopts = { noremap=true, silent=true, buffer=bufnr }
            if client.server_capabilities.definitionProvider then
              vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
            end
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
            vim.keymap.set('n', 'gR', vim.lsp.buf.rename, bufopts)
            vim.keymap.set('n', 'gh', vim.lsp.buf.hover, bufopts)
            vim.keymap.set('n', 'gs', vim.lsp.buf.document_symbol, bufopts)
            vim.keymap.set('n', 'gca', vim.lsp.buf.code_action, bufopts)
            vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, bufopts)
          end

          for _, server in ipairs({ "elmls", "gopls", "rnix", "zls" }) do
            require('lspconfig')[server].setup { on_attach = on_attach }
          end
          EOF
        '';
      }
    ];
  };
}
