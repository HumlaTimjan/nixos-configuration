{ config, lib, pkgs, ... }:
let
  cfg = config.elemental.home.programs.urxvt;
in
{
  options.elemental.home.programs.urxvt = {
    enable = lib.mkEnableOption "Enable urxvt terminal emulator";
  };

  config = lib.mkIf cfg.enable {
    pkgs.rxvt_unicode-with-plugins
    pkgs.urxvt_perl
  };
}
