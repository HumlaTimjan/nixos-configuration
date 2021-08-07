{ config, pkgs, lib, ... }:
{
  services.picom = {
    enable = true;
    backend = "glx";
    blur = true;
    fade = true;
    fadeSteps =  [ "0.1" "0.12" ];
    inactiveDim = "0.3";
    vSync = true;
    opacityRule = [
     "90:class_g  = 'URxvt'"
    ];
    extraOptions = ''
      corner-radius = 5.0;
    '';
    package = pkgs.picom.overrideAttrs(o: {
      src = pkgs.fetchFromGitHub {
        repo = "picom";
        owner = "ibhagwan";
        rev = "3680d323f5edf2ef5f21ab70a272358708c87a22";
        sha256 = "0wp91y6y2klbpcg8dn4h8bmbns759hak4r3paifgia5b3mmn4lr9";
      };
    });
  };
}
