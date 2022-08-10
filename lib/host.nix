{ system, pkgs, home-manager, lib, user, ... }:
with builtins;
{
  mkHost = { 
    name,
    hardwareConfiguration, 
    NICs, 
    fileSystems,
    systemConfig, 
    cpuCores, 
    users, 
    wifi ? [],
    gpuTempSensor ? null, 
    cpuTempSensor ? null
  }:
  let
    networkCfg = listToAttrs (map (n: {
      name = "${n}"; value = { useDHCP = true; };
    }) NICs);

    userCfg = {
      inherit name NICs systemConfig cpuCores gpuTempSensor cpuTempSensor;
    };

    sys_users = (map (u: user.mkSystemUser u) users);

  in lib.nixosSystem {
    inherit system;

    modules = [
      {
        imports = [ ../modules/system hardwareConfiguration ] ++ sys_users;

        br = systemConfig;

        fileSystems = fileSystems;

        networking.hostName = "${name}";
        networking.interfaces = networkCfg;

        networking.wireless.enable = false;
        networking.networkmanager.enable = true;
        networking.useDHCP = false;

        time.timeZone = "Europe/Stockholm";

        nixpkgs.pkgs = pkgs;
        nixpkgs.config = {
          allowUnfree = true;
        };

        nix.maxJobs = lib.mkDefault cpuCores;
        nix.package = pkgs.nixUnstable;
        nix.extraOptions = ''
          experimental-features = nix-command flakes
        '';
        
        system.stateVersion = "22.05";
      }
    ];
  };
}
