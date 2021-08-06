{ theme }:
{
  "*" = {
      yellow =           rgba ( 232, 174, 91, 100 % );
      red =              rgba ( 205, 92, 92, 100 % );
      tcyan =            rgba ( 204, 176, 196, 87 % );
      backlight =        rgba ( 204, 255, 238, 87 % );
      lightgreen =       rgba ( 136, 204, 34, 100 % );
      lightcyan =        rgba ( 176, 196, 222, 100 % );
      green =            rgba ( 134, 175, 128, 100 % );
      background-color = rgba ( 0, 0, 0, 0 % );
      lightred =         rgba ( 204, 85, 51, 100 % );
      font =             "Hasklug Nerd Font Mono, Hasklig Medium 11";
      tlightblack =      rgba ( 85, 68, 68, 80 % );
      lightmagenta =     rgba ( 153, 102, 0, 100 % );
      dark =             rgba ( 28, 28, 28, 100 % );
      lightblack =       rgba ( 85, 68, 68, 100 % );
      magenta =          rgba ( 222, 184, 135, 100 % );
      black =            rgba ( 61, 53, 42, 100 % );
      transparent =      rgba ( 0, 0, 0, 0 % );
      lightwhite =       rgba ( 221, 204, 187, 100 % );
      lightblue =        rgba ( 135, 206, 235, 100 % );
      lightyellow =      rgba ( 255, 167, 93, 100 % );
      cyan =             rgba ( 176, 196, 222, 100 % );
      white =            rgba ( 187, 170, 153, 100 % );
      foreground =       rgba ( 255, 238, 221, 100 % );
      blue =             rgba ( 100, 149, 237, 100 % );
      highlight =        bold underline rgba ( 255, 255, 255, 100 % );
  };
  "window" = {
      text-color =       var(magenta);
      transparency =     "screenshot";
      padding =          3px ;
      children =         [ mainbox ];
      orientation =      horizontal;
      location =         center;
      anchor =           center;
      background-color = var(transparent);
      border-radius =    3px ;
      border =           0px ;
      spacing =          0;
  };
  "mainbox" = {
      spacing =  0;
      children = [ inputbar,message,listview ];
  };
  "message" = {
      padding =          5;
      background-color = var(tcyan);
      border-color =     var(foreground);
      font =             "Hasklug Nerd Font Mono, Hasklig Medium 11";
      border =           0px 2px 2px ;
      text-color =       var(black);
  };
  "inputbar" = {
      padding =          11px ;
      background-color = var(tlightblack);
      border =           2px ;
      font =             "Hasklug Nerd Font Mono, Hasklig Medium 11";
      border-color =     var(foreground);
      border-radius =    15px 15px 0px 0px ;
      text-color =       var(lightgreen);
  };
  "entry" = {
      text-font =  inherit;
      text-color = inherit;
  };
  "prompt" = {
      text-font =  inherit;
      margin =     0px 0.3000em 0.0000em 0.0000em ;
      text-color = inherit;
  };
  "case-indicator" = {
      text-font =  inherit;
      text-color = inherit;
  };
  "listview" = {
      padding =          8px ;
      background-color = rgba ( 28, 28, 28, 80 % );
      dynamic =          false;
      border-color =     var(foreground);
      lines =            10;
      border-radius =    0px 0px 15px 15px ;
      border =           0px 2px 2px ;
  };
  "element" = {
      padding =          3px ;
      background-color = rgba ( 0, 0, 0, 0 % );
      vertical-align =   0.50;
      font =             inherit;
      border-radius =    4px ;
      text-color =       var(foreground);
  };
  "element selected.normal" = {
      background-color = var(blue);
  };
  "element selected.active" = {
      foreground =       var(dark);
      background-color = var(lightblue);
  };
  "element selected.urgent" = {
      foreground =       var(dark);
      background-color = var(lightred);
  };
  "element normal.active" = {
      foreground = var(lightblue);
  };
  "element normal.urgent" = {
      foreground = var(lightred);
  };
  "element alternate.active" = {
      foreground = var(lightblue);
  };
  "element alternate.urgent" = {
      foreground = var(lightred);
  };
  "vertb" = {
      expand =   false;
      children = [ dummy0,mode-switcher,dummy1 ];
  };
  "dummy0" = {
      expand = true;
  };
  "dummy1" = {
      expand = true;
  };
  "mode-switcher" = {
      orientation = vertical;
      expand =      false;
      spacing =     0px ;
      border =      0px ;
  };
  "button" = {
      text-color =       var(foreground);
      padding =          6px ;
      background-color = var(tlightblack);
      border-radius =    4px 0px 0px 4px ;
      font =             "Hasklug Nerd Font Mono, Hasklig Medium 11";
      border =           2px 0px 2px 2px ;
      horizontal-align = 0.50;
      border-color =     var(foreground);
  };
  "button selected.normal" = {
      background-color = var(backlight);
      border-color =     var(foreground);
      text-color =       var(dark);
      border =           2px 0px 2px 2px ;
  };
}
