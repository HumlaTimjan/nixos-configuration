{ pkgs, config, lib, ... }:
{
  imports = [
    ./bluetooth
    ./disk-encryption
    ./docker
    ./firewall
    ./graphics
    ./power-management
    ./printers
    ./sound
    ./ssh
    ./touchpad
    ./xserver
  ];
}
