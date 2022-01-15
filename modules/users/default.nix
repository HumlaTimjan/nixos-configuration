# .dotfiles/modules/users/default.nix
{ pkgs, config, lib, ... }:
{
  imports = [
    ./autorandr
    ./audio
    ./i3
    ./git
    ./colemak
    ./neovim
    ./bash
    ./alacritty
    ./urxvt
    ./picom
    ./polybar
    ./rofi
    ./x11
    ./fonts
  ];
}
