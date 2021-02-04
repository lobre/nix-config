{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      { 
        plugin = vim-go;
        config = ''
          let g:go_fmt_command = "goimports"
        '';
      }
    ];

    # extra packages available to nvim
    extraPackages = [];

    extraConfig = ''
      set showbreak=↪\
      set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨

      set ignorecase     " Case insensitive
      set wildignorecase " Autocomplete case insensitive
      set smartcase      " Enable case sensitivity if search contains upper letter
      set hidden         " No need to save a buffer before switching
      set smartindent    " Smart autoindenting when starting new line

      " Default tabs count parameters
      set tabstop=2
      set shiftwidth=2
      set expandtab

      " Language specific indentation settings
      autocmd FileType go setlocal noexpandtab shiftwidth=4 tabstop=4 softtabstop=4
      autocmd FileType sh setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4

      " Save with sudo
      command! W w !sudo tee % > /dev/null

      " Explorer settings
      let g:netrw_liststyle=3
      let g:netrw_winsize = 25
      let g:netrw_localrmdir='rm -r'

      " Trigger autoread when files changes on disk
      autocmd FocusGained * checktime

      " Reset some colors
      highlight SignColumn ctermbg=none
      highlight Error ctermbg=none ctermfg=red
      highlight Todo ctermbg=none ctermfg=red
      highlight Pmenu ctermbg=white
      highlight PmenuSel ctermbg=gray ctermfg=black
      highlight TabLineFill cterm=bold,reverse
      highlight TabLineSel cterm=bold,reverse
      highlight TabLine ctermbg=none ctermfg=none cterm=reverse
    '';
  };
}
