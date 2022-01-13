# .dotfiles/modules/users/default.nix
{ pkgs, config, lib, ... }:

{
  imports = [
    ./git
  ];
}
