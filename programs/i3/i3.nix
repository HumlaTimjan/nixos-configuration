{ config, pkgs, lib, ... }:
let
  mod = "Mod4";

  bgColor  = "#282828";
  red      = "#cc241d";
  green    = "#98971a";
  yellow   = "#d79921";
  blue     = "#458588";
  purple   = "#b16286";
  aqua     = "#689d68";
  gray     = "#a89984";
  darkgray = "#1d2021";
  white    = "#ffffff";
in
{
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      startup = [
        {
          command = ''${pkgs.xorg.setxkbmap}/bin/setxkbmap -option "caps:escape"'';
          always = true;
          notification = false;
        }
        {
          command = "screenrotator";
          always = true;
          notification = false;
        }
        {
          command = "nm-applet";
          always = true;
          notification = false;
        }
        {
          command = "blueman-applet";
          always = true;
          notification = false;
        }
      ];

      modifier = mod;

      fonts = ["Hasklug Nerd Font Mono,Hasklig Medium 11"];

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
          colors = {
            background = "${bgColor}";

            statusline = "${yellow}";

            focusedWorkspace = {
              border     = "${aqua}";
              background = "${aqua}";
              text       = "${darkgray}";
            };

            inactiveWorkspace = {
              border     = "${darkgray}";
              background = "${darkgray}";
              text       = "${yellow}";
            };

            activeWorkspace = {
              border     = "${darkgray}";
              background = "${darkgray}";
              text       = "${yellow}";
            };

            urgentWorkspace = {
              border     = "${red}";
              background = "${red}";
              text       = "${bgColor}";
            };
          };
        }
      ];

      colors = {
        background = "${bgColor}";
        
        focused = {
          border      = "${aqua}";
          background  = "${aqua}";
          text        = "${darkgray}";
          indicator   = "${purple}";
          childBorder = "${darkgray}";
        };
        
        unfocused = {
          border     = "${darkgray}";
          background = "${darkgray}";
          text       = "${yellow}";
          indicator   = "${purple}";
          childBorder = "${darkgray}";
        };
        
        focusedInactive = {
          border     = "${darkgray}";
          background = "${darkgray}";
          text       = "${yellow}";
          indicator   = "${purple}";
          childBorder = "${darkgray}";
        };
        
        urgent = {
          border     = "${red}";
          background = "${red}";
          text       = "${white}";
          indicator   = "${red}";
          childBorder = "${red}";
        };
      };

      window.titlebar = false;
    };
  };

  programs.i3status = {
    enable = true;
    enableDefault = false;
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

      "disk /" = {
        position = 1;
        settings = {
          # format = " hdd %avail "
          format = " ⛁ %avail ";
        };
      };

      "volume master" = {
        position = 2;
        settings = {
          format = "♪: %volume";
          format_muted = "♪: muted (%volume)";
          device = "default";
        };
      };

      "battery all" = {
        position = 3;
        settings = {
          format = "%status %percentage";
          format_down = "No battery";

          last_full_capacity = true;

          integer_battery_capacity = true;

          status_chr = "⚡";

          status_bat = "☉";

          status_unk = "";

          status_full = "☻";

          low_threshold = 15;
          threshold_type = "time";
        };
      };

      "memory" = {
        position = 4;
        settings = {
          format = "%used | %available";
          threshold_degraded = "1G";
          format_degraded = "MEMORY < %available";
        };
      };

      "tztime local" = {
        position = 5;
        settings = {
          format = " %Y-%m-%d %H:%M:%S ";
        };
      };
    };
  };
}
