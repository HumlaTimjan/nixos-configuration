{ config, lib, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "betongsuggan";
  home.homeDirectory = "/home/betongsuggan";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";

  fonts.fontconfig.enable = true;

  imports = [
    programs/neovim/neovim.nix
    programs/i3/i3.nix
    programs/alacritty/alacritty.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    glibcLocales
    xorg.setxkbmap
    xorg.libXft

    # Display Management
    autorandr
    brightnessctl
    i3lock-fancy-rapid

    # Development
    jetbrains.idea-community
    android-studio
    adoptopenjdk-hotspot-bin-15
    kotlin
    nodejs

    # Games
    steam
    retroarch

    # Utilities
    gitAndTools.diff-so-fancy
    ag
    chromium
    feh
    gparted
    htop
    nerdfonts
    unzip
    zoom-us

    # Communication
    slack
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    BROWSER = "chromium";
    LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
  };

  programs.bash = import ./programs/bash/bash.nix;
  elemental.home.programs.neovim.enable = true;

  xsession.enable = true;

  programs.git = {
    enable = true;
    userEmail = "rydback@gmail.com";
    userName = "Birger Rydback";

    extraConfig.core.pager = "diff-so-fancy | less --tabs=4 -RFX";

    aliases = {
      "f" = "fetch -pt";
      "s" = "status";
      "d" = "diff";
      "co" = "checkout";
      "br" = "checkout -b";
      "r"  = "rebase";

      # Commits, additions, and modifications
      "cm" = "commit -m";
      "ca" = "commit --amend";
      "aa" = "add .";
      "rh" = "reset --hard";
      "p"  = "push";
      "fp"  = "push --force-with-lease";

      # Logging
      "lgo" = "log --oneline --graph";
      "lo" = "log --oneline";
      "ln" = "log -n"; # follow with a number to show n logs
      "lon" = "log --oneline -n"; # follow with a number to show n logs
      "tree" = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
    };
  };
}
