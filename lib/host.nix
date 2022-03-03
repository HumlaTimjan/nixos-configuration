{ system, pkgs, home-manager, lib, user, ... }:
with builtins;
{
  mkHost = { 
    name, 
    NICs, 
    initrdMods, 
    kernelMods, 
    kernelParams, 
    kernelPackage,
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
        imports = [ ../modules/system ] ++ sys_users;

        br = systemConfig;

        environment.etc = {
          "hmsystemdata.json".text = toJSON userCfg;
        };

        fileSystems = fileSystems;

        networking.hostName = "${name}";
        networking.interfaces = networkCfg;

        networking.networkmanager.enable = true;
        networking.useDHCP = false;

        boot.initrd.availableKernelModules = initrdMods;
        boot.kernelModules = kernelMods;
        boot.kernelParams = kernelParams;
        boot.kernelPackages = kernelPackage;
        boot.kernel.sysctl = {
          "vm.max_map_count" = 262144;
        };
        hardware.enableRedistributableFirmware = true;
        hardware.enableAllFirmware = true;

        boot.loader.systemd-boot.enable = true;
        boot.loader.systemd-boot.configurationLimit = 5;
        boot.loader.efi.canTouchEfiVariables = true;
        boot.loader.grub.useOSProber = true;
        boot.loader.grub.configurationLimit = 6;

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

        powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

        system.stateVersion = "21.11";
      }
    ];
  };
}
