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
    programs/x/xresources.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    chromium
    glibcLocales
    rxvt-unicode-unwrapped
    xorg.setxkbmap
    xorg.xbacklight
    xorg.libXft

    # Development
    git
    jetbrains.idea-community
    jdk
    kotlin
    nodejs

    # Utilities
    ag
    autorandr
    feh
    htop
    nerdfonts
    powertop
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    BROWSER = "chromium";
    LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
    TERMINFO_DIRS = "${pkgs.rxvt-unicode-unwrapped.terminfo.outPath}/share/terminfo";                                                                                                                                             
  };

  programs.bash = import ./programs/bash/bash.nix;
  elemental.home.programs.neovim.enable = true;

  xsession.enable = true;

  programs.git = {
    enable = true;
    userEmail = "rydback@gmail.com";
    userName = "Birger Rydback";

    aliases = {
      "f" = "fetch -pt";
      "s" = "status";
      "d" = "diff";
      "co" = "checkout";
      "br" = "checkout -b";

      # Commits, additions, and modifications
      "cm" = "commit -m";
      "aa" = "add .";
      "rh" = "reset --hard";
      "p"  = "push";
      "fp"  = "push --force-with-lease";

      # Logging
      "lgo" = "log --oneline --graph";
      "lo" = "log --oneline";
      "ln" = "log -n"; # follow with a number to show n logs
      "lon" = "log --oneline -n"; # follow with a number to show n logs
    };
  };
}
