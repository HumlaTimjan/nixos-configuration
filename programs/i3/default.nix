{ config, pkgs, lib, ... }:
let
  theme = import ../../theming/theme.nix { };
  mod = "Mod4";
in
{
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    config = {
      startup = [
        {
          command = ''${pkgs.xorg.setxkbmap}/bin/setxkbmap -variant 'colemak,' -layout 'us,us' -option "caps:escape,compose:ralt,grp:shifts_toggle,"'';
          #command = ''${pkgs.xorg.setxkbmap}/bin/setxkbmap -layout us -option "caps:escape,compose:ralt,grp:shifts_toggle,"'';
          always = true;
          notification = false;
        }
        {
          command = "systemctl --user restart polybar.service";
          always = true;
          notification = false;
        }
        {
          command = "systemctl --user restart picom.service";
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
        {
          command = "urxvtd -q -o -f";
          always = true;
          notification = false;
        }
        {
          command = "feh --bg-center ~/Pictures/nix-background.png";
          always = false;
          notification = false;
        }
      ];

      modifier = mod;

      fonts = {
        names = [ theme.font.name ];
        style = theme.font.style;
        size = theme.font.size;
      };

      keybindings = lib.mkOptionDefault {
        "${mod}+Return" = "exec urxvt";
        "${mod}+x" = "exec sh -c '${pkgs.maim}/bin/maim -s | xclip -selection clipboard -t image/png'";
        "${mod}+o" = "exec rofi -show run";
        "${mod}+Shift+x" = "exec sh -c '${pkgs.i3lock-fancy-rapid}/bin/i3lock-fancy-rapid 15 8'";

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

        # Multi monitors
        "${mod}+p" = "exec autorandr --change && feh --bg-center ~/Pictures/nix-background.png";

        # Multimedia Keys

        ## Volume 
        XF86AudioRaiseVolume = "exec --no-startup-id pactl set-sink-volume 0 +5%";
        XF86AudioLowerVolume = "exec --no-startup-id pactl set-sink-volume 0 -5%";
        XF86AudioMute = "exec --no-startup-id pactl set-sink-mute 0 toggle";

        ## Backlighting
        XF86MonBrightnessUp = "exec brightnessctl set +10%";
        XF86MonBrightnessDown = "exec brightnessctl set 10%-";

      };

      bars = [];
      #bars = with theme.colors; [
      #  {
      #    position = "bottom";
      #    statusCommand = "${pkgs.i3status}/bin/i3status";
      #    colors = {
      #      background = "${background}";

      #      statusline = "${utilityText}";

      #      focusedWorkspace = {
      #        border     = "${thirdText}";
      #        background = "${thirdText}";
      #        text       = "${borderDark}";
      #      };

      #      inactiveWorkspace = {
      #        border     = "${borderDark}";
      #        background = "${borderDark}";
      #        text       = "${utilityText}";
      #      };

      #      activeWorkspace = {
      #        border     = "${borderDark}";
      #        background = "${borderDark}";
      #        text       = "${utilityText}";
      #      };

      #      urgentWorkspace = {
      #        border     = "${alertText}";
      #        background = "${alertText}";
      #        text       = "${background}";
      #      };
      #    };
      #  }
      #];

      gaps = {
        bottom = 10;
        top = 10;
        horizontal = 10;
        vertical = 10;
        outer = 10;
        inner = 10;
        left = 10;
        right = 10;
        #smartBorders = "no_gaps";
        smartGaps = true;
      };

      colors =  with theme.colors; {
        background = "${background}";
        
        focused = {
          border      = "${thirdText}";
          background  = "${thirdText}";
          text        = "${borderDark}";
          indicator   = "${purple}";
          childBorder = "${borderDark}";
        };
        
        unfocused = {
          border     = "${borderDark}";
          background = "${borderDark}";
          text       = "${utilityText}";
          indicator   = "${purple}";
          childBorder = "${borderDark}";
        };
        
        focusedInactive = {
          border     = "${borderDark}";
          background = "${borderDark}";
          text       = "${borderDark}";
          indicator   = "${purple}";
          childBorder = "${borderDark}";
        };
        
        urgent = {
          border     = "${alertText}";
          background = "${alertText}";
          text       = "${mainText}";
          indicator   = "${mainText}";
          childBorder = "${mainText}";
        };
      };

      window.titlebar = false;
      #window.border = 4;
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
  
      "cpu_temperature 1" = {
        position = 0.5;
        settings = {
          format = "%degrees °C";
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
