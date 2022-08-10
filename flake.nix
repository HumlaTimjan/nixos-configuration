{
  description = "Betongsuggan's flake to rule them all. Proudly stolen from https://jdisaacs.com/blog/nixos-config/";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-hardwares.url = "github:NixOS/nixos-hardware";
  };

  outputs = { nixpkgs, home-manager, nixos-hardware, ...}@inputs:
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

    system = "aarch64-linux";
  in {
    homeManagerConfigurations = {
      monitoring = user.mkHMUser {
        userConfig = {
          git = {
            enable = true;
            userName = "HumlaBot";
            userEmail = "engineering+humlabot@humla.io";
          };
          general.enable = true;
	        fonts.enable = true;
          keyboard.enable = true;
          browsers.enable = true;
          autorandr.enable = true;
          audio.enable = true;
          neovim.enable = true;
          urxvt.enable = true;
          bash.enable = true;
          i3.enable = true;
          rofi.enable = true;
          polybar.enable = true;
          x11.enable = true;
        };
        username="humla-dashboard";
      };
    };

    nixosConfigurations = {
      humla-dashboards = host.mkHost {
          name = "humla-dashboards";
          hardwareConfiguration = nixos-hardware.nixosModules.raspberry-pi-4;
          NICs = [ "wlan0" ]; 
          fileSystems = {
            "/" = {
              device = "/dev/disk/by-label/NIXOS_SD";
              fsType = "ext4";
              options = [ "noatime" ];
            };
          };
          systemConfig = {
            bluetooth.enable = true;
            xserver.enable = true;
            firewall = {
              enable = false;
              tcpPorts = [ 8080 ];
            };
            ssh.enable = true;
          };
          users = [{
            name = "humla-dashboard";
            groups = [ "wheel" "networkmanager" ];
            uid = 1000;
            shell = pkgs.bash;
          }];
          cpuCores = 4;
      };
    };
  };
}
