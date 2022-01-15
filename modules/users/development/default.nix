{ config, pkgs, lib, ... }:
with lib;

let
  cfg = config.br.development;
in {
  options.br.development = {
    enable = mkEnableOption "Enable Java/Kotlin development";
  };

  config = mkIf (cfg.enable) {
    home.packages = with pkgs; [ 
      ag
      altair
      adoptopenjdk-hotspot-bin-15
      awscli2
      gnumake
      jetbrains.idea-ultimate
      jq
      kotlin
      newman
      nodejs
      postman
    ];
    home.sessionVariables = {
      JAVA_HOME = "${pkgs.adoptopenjdk-hotspot-bin-15}";
      PATH="$HOME/.npm-packages/bin:$PATH";
    };
  };
}
