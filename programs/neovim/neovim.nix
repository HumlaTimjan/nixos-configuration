{ config, pkgs, lib, ... }:
let
  cfg = config.elemental.home.programs.neovim;
in
{
  options.elemental.home.programs.neovim = {
    enable = lib.mkEnableOption "Enable the vim editor";
  };

  config = lib.mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      extraConfig = " 
        set nocompatible
        set relativenumber
        syntax on
        set nowrap
        set encoding=utf8
        set hidden
 
        set nobackup
        set nowritebackup
        set updatetime=100
        set ttimeout
        set timeoutlen=1000
        set ttimeoutlen=5

	      \" Show linenumbers
	      set number
	      set ruler

	      \" Set Proper Tabs
	      set tabstop=2
	      set shiftwidth=2
	      set smarttab
	      set expandtab

	      \" Always display the status line
	      set laststatus=2

              colorscheme gruvbox
	      \"let g:lightline.colorscheme = 'gruvbox'
	      let g:VIM_COLOR_SCHEME = 'gruvbox'

        \" --- Auto commands
        autocmd FileType c,cpp,java,php,json :autocmd BufWritePre <buffer> %s/\s\+$//e

      ";
      plugins = with pkgs.vimPlugins; [
	      # Developer plugins
	      coc-nvim
	      coc-yaml
	      coc-json

	      # Themes
        gruvbox
      ];
    };    
  };
    

#    xdg.configFile."nvim/coc-settings.json".source =
#      builtins.toFile "coc-settings.json" (builtins.toJSON (coc { config = config; }));
#    xdg.configFile."nvim/fixers.vimrc".source = ./configs/fixers.vimrc;
#    xdg.configFile."nvim/flags.vimrc".source = ./configs/flags.vimrc;
#    xdg.configFile."nvim/general.vimrc".source = ./configs/general.vimrc;
#    xdg.configFile."nvim/keys.vimrc".source = ./configs/keys.vimrc;
#    xdg.configFile."nvim/lsp.vimrc".source = ./configs/lsp.vimrc;
#    xdg.configFile."nvim/status-line.vimrc".source = ./configs/status-line.vimrc;
#    xdg.configFile."nvim/vista.vimrc".source = ./configs/vista.vimrc;
#    xdg.configFile."nvim/init.vimrc".source = ./configs/init.vimrc;
#    xdg.configFile."nvim/init.vim".source = ./configs/init.vim;
#    xdg.configFile."nvim/themes.vimrc".source = ./configs/themes.vimrc;
}
