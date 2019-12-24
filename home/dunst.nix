{ config, pkgs, ... }:

{
  services.dunst = {
    enable = true;

    iconTheme = {
      package = pkgs.arc-icon-theme;
      name = "Arc";
    };

    settings = {
      global = {
        font = "M+ 1mn 12";
        allow_markup = true;
        format = " <b>%s</b>\n%b";
        sort = true;
        indicate_hidden = true;
        alignment = "left";
        bounce_freq = 0;
        show_age_threshold = 60;
        word_wrap = true;
        ignore_newline = false;
        geometry = "250x50-24+24";
        shrink = true;
        transparency = 5;
        idle_threshold = 120;
        monitor = 0;
        follow = "mouse";
        sticky_history = true;
        history_length = 20;
        show_indicators = false;
        line_height = 4;
        separator_height = 0;
        padding = 8;
        horizontal_padding = 8;
        separator_color = "auto";
        startup_notification = false;
        dmenu = "${pkgs.rofi}/bin/rofi -dmenu -p dunst:";
        browser = "xdg-open";
        icon_position = false;
        stack_duplicates = false;
        hide_duplicate_count = true;

      };

      frame = {
        width = 2;
        color = "#2f343f";
      };

      shortcuts = {
        close = "mod4+d";
        context = "mod4+shift+d";
      };

      urgency_low = {
        timeout = 2;
        background = "#2f343f";
        foreground = "#d8dee8";
      };

      urgency_normal = {
        timeout = 4;
        background = "#2f343f";
        foreground = "#d8dee8";
      };

      urgency_critical = {
        timeout = 0;
        background = "#2f343f";
        foreground = "#d8dee8";
        frame_color = "#bf616a";
      };
    };
  };
}