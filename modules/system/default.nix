{ pkgs, config, lib, ... }:
{
  imports = [
    ./touchpad
    ./graphics
    ./sound
    ./docker
    ./bluetooth
    ./power-management
    ./xserver
  ];
}
