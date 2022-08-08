{ pkgs, config, lib, ...}:
with lib;

let
  cfg = config.br.keyboard;
in {
  options.br.keyboard = {
    enable = mkEnableOption "Configure keyboard layout";
  };

  config = mkIf (cfg.enable) {
    home.keyboard = {
      layout = "se,us,us";
      variant = ",colemak,";
      options = [
        "caps:escape"
        "compose:ralt"
        "grp:shifts_toggle"
      ];
    };
  };
}
