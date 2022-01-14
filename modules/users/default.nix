# .dotfiles/modules/users/default.nix
{ pkgs, config, lib, ... }:
{
  imports = [
    ./i3
    ./git
    ./neovim
    ./bash
    ./alacritty
    ./urxvt
  ];
}
