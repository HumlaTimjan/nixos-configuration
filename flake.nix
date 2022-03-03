{
  description = "Betongsuggan's flake to rule them all. Proudly stolen from https://jdisaacs.com/blog/nixos-config/";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ...}@inputs:
  let
    inherit (nixpkgs) lib;
    
    util = import ./lib {
      inherit system pkgs home-manager lib; overlays = (pkgs.overlays);
    };

    inherit (util) user;
    inherit (util) host;

    pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [];
    };

    system = "x86_64-linux";
  in {
    homeManagerConfigurations = {
      private = user.mkHMUser {
        userConfig = {
          git = {
            enable = true;
            userName = "Betongsuggan";
            userEmail = "rydback@gmail.com";
          };
          general.enable = true;
          communication.enable = true;
          browsers.enable = true;
          autorandr.enable = true;
          audio.enable = true;
          neovim.enable = true;
          urxvt.enable = true;
          bash.enable = true;
          i3.enable = true;
          rofi.enable = true;
          polybar.enable = true;
          picom.enable = true;
          fonts.enable = true;
          x11.enable = true;
          colemak.enable = true;
          development.enable = true;
          games.enable = true;
        };
        username="betongsuggan";
      };
      work = user.mkHMUser {
        userConfig = {
          git = {
            enable = true;
            userName = "Birger Rydback";
            userEmail = "birger@humla.io";
          };
          general.enable = true;
          communication.enable = true;
          browsers.enable = true;
          autorandr.enable = true;
          audio.enable = true;
          neovim.enable = true;
          urxvt.enable = true;
          bash.enable = true;
          i3.enable = true;
          rofi.enable = true;
          polybar.enable = true;
          picom.enable = true;
          fonts.enable = true;
          x11.enable = true;
          colemak.enable = true;
          development.enable = true;
        };
        username="birgerrydback";
      };
    };

    nixosConfigurations = {
      laptop = host.mkHost {
          name = "nixos";
          NICs = [ "wlp0s20f3" ]; 
          kernelPackage = pkgs.linuxPackages_5_15;
          initrdMods = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
          kernelMods = [ "kvm-intel" "iwlwifi" ];
          kernelParams = [];
          fileSystems = {
            "/" = {
              device = "/dev/disk/by-uuid/e6fa26ba-7e3a-4146-8bba-54fd65aa211a";
              fsType = "ext4";
            };
  
            "/boot" = {
              device = "/dev/disk/by-uuid/C8DA-ECD3";
              fsType = "vfat";
            };
          };
          systemConfig = {
            touchpad.enable = true;
            graphics.enable = true;
            sound.enable = true;
            docker.enable = true;
            bluetooth.enable = true;
            xserver.enable = true;
            power-management.enable = true;
          };
          users = [{
            name = "betongsuggan";
            groups = [ "wheel" "networkmanager" "video" "docker" ];
            uid = 1000;
            shell = pkgs.bash;
          }];
          cpuCores = 4;
      };
      laptop-work = host.mkHost {
          name = "nixos";
          NICs = [ "wlp0s20f3" ]; 
          kernelPackage = pkgs.linuxPackages_5_15;
          initrdMods = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
          kernelMods = [ "kvm-intel" "iwlwifi" ];
          kernelParams = [];
          fileSystems = {
            "/" = { 
              device = "/dev/disk/by-uuid/7027e0ee-fd6a-41e8-a0b3-ea0b4855fcce";
              fsType = "ext4";
            };
        
            "/boot" ={ 
              device = "/dev/disk/by-uuid/F65E-B142";
              fsType = "vfat";
            };
          };
          systemConfig = {
            touchpad.enable = true;
            graphics.enable = true;
            sound.enable = true;
            docker.enable = true;
            bluetooth.enable = true;
            xserver.enable = true;
            printers.enable = true;
            power-management.enable = true;
            diskEncryption = {
              enable = true;
              diskId = "da540ce4-42b1-4020-a014-99cdc57fcbdc";
            };
            firewall = {
              enable = true;
              tcpPorts = [ 8080 ];
            };
          };
          users = [{
            name = "birgerrydback";
            groups = [ "wheel" "networkmanager" "video" "docker" ];
            uid = 1000;
            shell = pkgs.bash;
          }];
          cpuCores = 6;
      };
    };
  };
}
