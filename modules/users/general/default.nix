{ config, lib, pkgs, ... }:
with lib;

let
  cfg = config.br.general;
in {
  options.br.general = {
    enable = mkEnableOption "Enable general desktop programs";
  };

  config = mkIf (cfg.enable) {
    home.packages = with pkgs; [
      bpytop
      exfat
      gnome3.gedit
      gparted     
      htop    
      p7zip     
      lm_sensors
      unzip          
      xfce.thunar            
      xfce.thunar-volman     
      gvfs
      polkit
      udisks
    ];
  };
}
