{ config, lib, pkgs, ... }:
with lib;

let
  cfg = config.br.ssh;
in {
  options.br.ssh = {
    enable = mkEnableOption "Enable ssh";
  };

  config = mkIf (cfg.enable) {
    programs.ssh.startAgent = true;
    services.openssh.enable = true;
  };
}
