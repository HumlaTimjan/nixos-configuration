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

        fileSystems."/" = { 
          device = "/dev/disk/by-uuid/e6fa26ba-7e3a-4146-8bba-54fd65aa211a";
          fsType = "ext4";
        };
  
        fileSystems."/boot" = { 
          device = "/dev/disk/by-uuid/C8DA-ECD3";
          fsType = "vfat";
        };

        networking.hostName = "${name}";
        networking.interfaces = networkCfg;
        networking.wireless.interfaces = wifi;

        networking.networkmanager.enable = true;
        networking.useDHCP = false;

        boot.initrd.availableKernelModules = initrdMods;
        boot.kernelModules = kernelMods;
        boot.kernelParams = kernelParams;
        boot.kernelPackages = kernelPackage;
        boot.kernel.sysctl = {
          "vm.max_map_count" = 262144;
        };

        boot.loader.systemd-boot.enable = true;
        boot.loader.systemd-boot.configurationLimit = 5;
        boot.loader.efi.canTouchEfiVariables = true;
        boot.loader.grub.useOSProber = true;
        boot.loader.grub.configurationLimit = 6;

        time.timeZone = "Europe/Stockholm";
        i18n.defaultLocale = "en_US.UFT-8";

        nixpkgs.pkgs = pkgs;

        nix.maxJobs = lib.mkDefault cpuCores;
        nix.package = pkgs.nixUnstable;
        nix.extraOptions = ''
          experimental-features = nix-command flakes
        '';

        system.stateVersion = "21.11";
      }
    ];
  };
}
