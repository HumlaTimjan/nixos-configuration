{ config, pkgs, lib, ... }:
let
  theme = import ../../theming/theme.nix {};
in
{
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3GapsSupport = true;
      pulseSupport = true;
    };
    config = with builtins; {
      "bar/bottom" = {
        monitor = "eDP-1";
        bottom = true;
        width = "100%";
        height = "2%";
        radius = 0;
        wm-restack = "i3";
        modules-center = "i3";
        modules-right = "pulseaudio";
        background = theme.colors.background;
        foreground = theme.colors.utilityText;
        font-0 = "${theme.font.name},${theme.font.style}:size=10";
        tray-position = "right";
      };
      "module/i3" = {
        type = "internal/i3";
      };
      "module/pulseaudio" = {
        type = "internal/pulseaudio";
        sink = "alsa_output.pci-0000_00_1f.3.analog-stereo";
        use-ui-max = false;
        interval = 5;
        label-muted = "muted";
        label-muted-foreground = "#666";
# Only applies if <ramp-volume> is used
        ramp-volume-0 = "🔈";
        ramp-volume-1 = "🔉";
        ramp-volume-2 = "🔊";
      };
      "module/date" = {
        type = "internal/date";
        internal = 5;
        date = "%Y-%m-%d";
        time = "%H:%M";
        label = "%date% %time%";
      };
    };
    script = import ./launcher.nix { pkgs = pkgs; };
  };
}
