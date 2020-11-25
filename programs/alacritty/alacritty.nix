{
  programs.alacritty = {
    enable = true;

    settings = {
      live_config_reload = true;
      font   = import ./fonts.nix;
      colors = import ./colors.nix;
    };
  };
}
