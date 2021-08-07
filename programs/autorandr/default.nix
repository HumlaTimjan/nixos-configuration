{ config, pkgs, lib, ... }:
{
  programs.autorandr = {
    enable = true;
    profiles = {
      "work-laptop" = {
        fingerprint = {
          eDP-1 = "00ffffffffffff004d10d11400000000041e0104a52215780ede50a3544c99260f505400000001010101010101010101010101010101283c80a070b023403020360050d210000018203080a070b023403020360050d210000018000000fe00464b52314b804c513135364e31000000000002410332001200000a010a2020003";
        };
        config = {
          eDP-1 = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "0x0";
            mode = "1920x1200";
            rate = "59.95";
          };
        };
      };
    };
  };
}
