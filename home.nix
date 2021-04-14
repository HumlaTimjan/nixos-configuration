{ config, lib, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "birgerrydback";
  home.homeDirectory = "/home/birgerrydback";

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
    programs/x/xresources.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    glibcLocales
    xorg.setxkbmap
    xorg.libXft
    rxvt-unicode-unwrapped

    # Display Management
    autorandr
    brightnessctl
    i3lock-fancy-rapid

    # Development
    adoptopenjdk-hotspot-bin-15
    awscli2
    docker-compose
    gnumake
    jetbrains.idea-community
    jq
    kotlin
    nodejs

    # Utilities
    gitAndTools.diff-so-fancy
    ag
    exfat
    feh
    gimp
    gnome3.gedit
    gparted
    gthumb
    htop
    kazam
    lastpass-cli
    p7zip
    nerdfonts
    newman
    pgcli
    postman
    unzip
    zoom-us

    # Communication
    slack
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    BROWSER = "firefox";
    LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
    TERMINFO_DIRS = "${pkgs.rxvt-unicode-unwrapped.terminfo.outPath}/share/terminfo";
  };

  programs.bash = import ./programs/bash/bash.nix;
  elemental.home.programs.neovim.enable = true;

  xsession.enable = true;

  programs.git = {
    enable = true;
    userEmail = "birger@humla.io";
    userName = "Birger Rydback";

    extraConfig.core.pager = "diff-so-fancy | less --tabs=4 -RFX";

    aliases = {
      "f" = "fetch -pt";
      "s" = "status";
      "d" = "diff";
      "dn" = "diff --name-only";
      "co" = "checkout";
      "br" = "checkout -b";
      "r"  = "rebase";

      # Commits, additions, and modifications
      "cm" = "commit -m";
      "ca" = "commit --amend";
      "aa" = "add .";
      "au" = "add -u";
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
