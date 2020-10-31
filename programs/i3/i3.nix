{ config, pkgs, lib, ... }:
let
  mod = "Mod4";
in
{
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      startup = [
        {
          command = ''${pkgs.xorg.setxkbmap}/bin/setxkbmap -option "caps:escape"'';
          always = true;
        }
      ];

      modifier = mod;

      fonts = ["DejaVu Sans Mono, FontAwesome 9"];

      keybindings = lib.mkOptionDefault {
        "${mod}+Return" = "exec urxvt";
        "${mod}+p" = "exec ${pkgs.dmenu}/bin/dmenu_run";
        "${mod}+x" = "exec sh -c '${pkgs.maim}/bin/maim -s | xclip -selection clipboard -t image/png'";
#        "${mod}+Shift+x" = "exec sh -c '${pkgs.i3lock-fancy-rapid}/bin/i3lock-fancy-rapid 5 3'";

        # Focus
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";

        # Move
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";

        # My multi monitor setup
        "${mod}+m" = "move workspace to output DP-2";
        "${mod}+Shift+m" = "move workspace to output DP-5";

        # Multimedia Keys

        ## Volume 
        XF86AudioRaiseVolume = "exec --no-startup-id pactl set-sink-volume 0 +5%";
        XF86AudioLowerVolume = "exec --no-startup-id pactl set-sink-volume 0 -5%";
        XF86AudioMute = "exec --no-startup-id pactl set-sink-mute 0 toggle";

        ## Backlighting
        XF86MonBrightnessUp = "exec xbacklight -inc 10";
        XF86MonBrightnessDown = "exec xbacklight -dec 10";
      };

      bars = [
        {
          position = "bottom";
          statusCommand = "${pkgs.i3status}/bin/i3status";
        }
      ];

      window.commands = [
        {
          command = "border pixel 1"; 
          criteria = { 
            class = "*"; 
          };
        }
      ];
    };
  };

  programs.i3status = {
    enable = true;
    general = {
      colors = true;
      interval = 5;
      color_good = "#2AA198";
      color_bad = "#586E75";
      color_degraded = "#DC322F";
    };
    modules = {
      "cpu_usage" = {
        position = 0;
        settings = {
          format = " cpu  %usage ";
        };
      };
      "load" = {
        position = 1;
        settings = {
          format = " load %1min ";
          # max_threshold = 0.3
        };
      };
      "disk /" = {
        position = 2;
        settings = {
          # format = " hdd %avail "
          format = " ⛁ %avail ";
        };
      };
      "ethernet _first_" = {
        position = 3;
        settings = {
          # if you use %speed, i3status requires root privileges
          format_up = " lan: %ip %speed ";
          format_down = " no lan ";
        };
      };
      "volume master" = {
        position = 3.9;
        settings = {
          format = "♪: %volume";
          format_muted = "♪: muted (%volume)";
          device = "default";
        };
      };
      "battery all" = {
        position = 4;
        settings = {
          format = "%status %percentage";
          format_down = "No battery";

          last_full_capacity = true;

          integer_battery_capacity = true;

          # status_chr = "";
          status_chr = "⚡";

          # status_bat = "bat";
          # status_bat = "☉";
          status_bat = "";

          # status_unk = "?";
          status_unk = "";

          # status_full = "";
          status_full = "☻";

          low_threshold = 15;
          threshold_type = "time";
        };
      };

      "memory" = {
        position = 5;
        settings = {
          format = "%used | %available";
          threshold_degraded = "1G";
          format_degraded = "MEMORY < %available";
        };
      };

      "tztime local" = {
        position = 6;
        settings = {
          # format = "%Y-%m-%d %H:%M:%S";
          format = " %Y-%m-%d. %H:%M:%S ";
        };
      };
    };
  };
}
