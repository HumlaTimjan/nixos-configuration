{ config, lib, pkgs, ... }:
with lib;

let
  cfg = config.br.diskEncryption;
in {
  options.br.diskEncryption = {
    enable = mkEnableOption "Enable Disk Encryption";

    diskId = mkOption {
      description = "UUID of disk that is encrypted by Luks";
      type = types.str;
    };
  };

  config = mkIf (cfg.enable) {
    boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-uuid/${cfg.diskId}";
  };
}
