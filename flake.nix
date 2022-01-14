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
      br = user.mkHMUser {
        userConfig={
          git = {
            enable = true;
            userName = "Betongsuggan";
            userEmail = "rydback@gmail.com";
          };
          autorandr.enable = true;
          neovim.enable = true;
          urxvt.enable = true;
          bash.enable = true;
          i3.enable = true;
          rofi.enable = true;
          polybar.enable = true;
        };
        username="betongsuggan";
      };
    };

    #nixosConfigurations = {
    #  laptop = host.mkHost {
    #    # ...
    #  };
    #};
  };
}
