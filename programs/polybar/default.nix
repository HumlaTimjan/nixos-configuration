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
        modules-right = "date pulseaudio battery";
        background = theme.colors.background;
        foreground = theme.colors.utilityText;
        font-0 = "${theme.font.name},${theme.font.style}:size=10";
        font-1 = "${theme.font.name},${theme.font.style}:size=25";
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
        label-muted = "";
        label-muted-font = 2;
        label-muted-foreground = "#666";
        format-volume = "<ramp-volume>";
        format-volume-font = 2;
# Only applies if <ramp-volume> is used
        ramp-volume-0 = "";
        ramp-volume-1 = "";
        ramp-volume-2 = "";
      };
      "module/battery" = {
        type = "internal/battery";
        battery = "BAT0";
        adapter = "ADP1";
        full-at = "98";
        
        format-charging = "<animation-charging>";
        format-charging-font = 2;
        format-discharging = "<ramp-capacity>";
        format-discharging-font = 2;
        format-full-font = 2;
        label-full = "";
        
        ramp-capacity-0 = "";
        ramp-capacity-0-foreground = "${theme.colors.alertText}";
        ramp-capacity-1 = "";
        ramp-capacity-1-foreground = "${theme.colors.utilityText}";
        ramp-capacity-2 = "";
        ramp-capacity-3 = "";
        ramp-capacity-4 = "";
        ramp-capacity-foreground = "${theme.colors.secondaryText}";
        
        animation-charging-0 = "";
        animation-charging-1 = "";
        animation-charging-2 = "";
        animation-charging-3 = "";
        animation-charging-4 = "";
        animation-charging-foreground = "${theme.colors.secondaryText}";
        animation-charging-framerate = "750";
      };
      "module/date" = {
        type = "internal/date";
        internal = 5;
        date = "%Y-%m-%d";
        time = "%H:%M:%S";
        label = "%date% %time%";
      };
    };
    script = import ./launcher.nix { pkgs = pkgs; };
  };
}
