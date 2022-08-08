{ pkgs, config, lib, ... }:
{
  imports = [
    ./general
    ./autorandr
    ./audio
    ./i3
    ./git
    ./keyboard
    ./communication
    ./development
    ./neovim
    ./bash
    ./alacritty
    ./urxvt
    ./picom
    ./polybar
    ./rofi
    ./x11
    ./fonts
    ./games
    ./browsers
  ];
}
