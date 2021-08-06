{ pkgs, ... }:

let
  theme = import ../../theming/theme.nix;
  config = import ./rofi-config.nix { theme = theme; };
in
{
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.alacritty}/bin/urxvt";
    theme = "gruvbox-dark-soft";
  };
}
