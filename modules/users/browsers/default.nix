{ config, lib, pkgs, ... }:
with lib;

let
  cfg = config.br.browsers;
in {
  options.br.browsers = {
    enable = mkEnableOption "Enable browser packages";

    defaultBrowser = mkOption {
      description = "Default browser for the system";
      type = types.str;
      default = "chromium";
    };
  };

  config = mkIf (cfg.enable) {
    home.packages = with pkgs; [
      chromium
      firefox
      tor-browser-bundle-bin
    ];
    home.sessionVariables = {
      BROWSER = cfg.defaultBrowser;
    };
  };
}
