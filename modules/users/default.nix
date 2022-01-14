# .dotfiles/modules/users/default.nix
{ pkgs, config, lib, ... }:
{
  imports = [
    ./autorandr
    ./i3
    ./git
    ./neovim
    ./bash
    ./alacritty
    ./urxvt
    ./picom
    ./polybar
    ./rofi
    ./x11
  ];
}
