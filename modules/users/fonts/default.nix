{ config, lib, pkgs, ...}:
with lib;

let
  cfg = config.br.fonts;
  myFonts = pkgs.nerdfonts.override { fonts = ["Hasklig"]; };
in {
  options.br.fonts = {
    enable = mkEnableOption "Enable additional fonts";
  };

  config = mkIf (cfg.enable) {
    fonts.fontconfig.enable = true;
    home.packages = with pkgs; [ glibcLocales myFonts xorg.libXft ];
    home.sessionVariables = {
      LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
    };
  };
}
  
