{ config, lib, pkgs, ... }:
with lib;

let
  cfg = config.br.urxvt;
in
{
  options.br.urxvt = {
    enable = mkEnableOption "Enable urxvt terminal emulator";
  };

  config = mkIf (cfg.enable) {
    programs.urxvt = {
      enable = true;
      iso14755 = true;
      scroll.bar.enable = false;
      extraConfig = {
        cursorBlink = true;
      };
      keybindings = {
        "Shift-Control-V" = "eval:paste_clipboard";
        "Shift-Control-C" = "eval:selection_to_clipboar";
      };
      fonts = [
        "xft:Hasklug Nerd Font Mono,Hasklig Medium:style=Medium,Regular:pixelsize=11"
        "xft:Hasklug Nerd Font Mono:style=Bold:pixelsize=15"
        "xft:Hasklug Nerd Font Mono:style=Italic:pixelsize=15"
        "xft:Hasklug Nerd Font Mono:style=Bold Italic:pixelsize=15"
      ];
    };
  };
}
