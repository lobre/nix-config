{ config, pkgs, ... }:

{
  # Enable xsession
  xsession.enable = true;
 
  # Enable numlock
  xsession.numlock.enable = true;

  # Used to configure xsession user service
  home.keyboard = {
    layout = "fr";
    variant = "bepo";

    # Use caps lock as escape
    options = [ "caps:escape" ];
  };

  home.packages = with pkgs; [
    # theme
    arc-icon-theme
    arc-theme

    # i3
    arandr
    i3blocks
    i3status
    libnotify
    lxappearance
    pavucontrol
    shutter

    # apps
    discord
    filezilla
    firefox 
    gnome3.gnome-control-center
    gnome3.eog
    gnome3.gucharmap
    gnome3.meld
    gnome3.sushi
    google-chrome
    mattermost-desktop
    networkmanager
    obsidian
    pantheon.elementary-files
    pavucontrol
    peek
    remmina
    shutter
    skype
    slack-dark
    spotify
    teams
  ];

  gtk = {
    enable = true;

    theme = {
      package = pkgs.arc-theme;
      name = "Arc-Darker";
    };

    iconTheme = {
      package = pkgs.arc-icon-theme;
      name = "Arc";
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  # Allow XDG linking
  xdg.enable = true;

  imports = [
    ./gui/i3.nix
    ./gui/i3status.nix
    ./gui/rofi.nix
    ./gui/greenclip.nix
    ./gui/alacritty.nix
    ./gui/xresources.nix
    ./gui/picom.nix
    ./gui/dunst.nix
    ./gui/oni2.nix
    ./gui/sway.nix
    ./gui/mako.nix
    ./gui/wofi.nix
  ];
}
