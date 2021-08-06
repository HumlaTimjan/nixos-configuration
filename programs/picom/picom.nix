{ config, pkgs, lib, ... }:
{
  services.picom = {
    enable = true;
    blur = true;
    fade = true;
    fadeSteps =  [ "0.1" "0.12" ];
    inactiveDim = "0.3";
    vSync = true;
    opacityRule = [
     "90:class_g  = 'URxvt'"
    ];
  };
}
