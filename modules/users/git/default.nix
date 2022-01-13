# .dotfiles/modules/users/git/default.nix
{ pkgs, config, lib, ... }:
with lib;

let
  cfg = config.br.git;
in {
  options.br.git = {
    enable = mkOption {
      description = "Enable git";
      type = types.bool;
      default = false;
    };

    userName = mkOption {
      description = "Name for git";
      type = types.str;
      default = "Birger Rydback";
    };

    userEmail = mkOption {
      description = "Email for git";
      type = types.str;
      default = "birger@humla.io";
    };
  };

  config = mkIf (cfg.enable) {
    programs.git = {
      enable = true;
      userName = cfg.userName;
      userEmail = cfg.userEmail;
      extraConfig = {
        credential.helper = "${
            pkgs.git.override { withLibsecret = true; }
          }/bin/git-credential-libsecret";
      };
    };
  };
}
