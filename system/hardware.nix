{ config, pkgs, ... }:

{
  # Brightness control
  hardware.brightnessctl.enable = true;

  # Touchpad support
  services.xserver.libinput = {
    enable = true;
    naturalScrolling = true;
  };

  # Optimize battery life
  services.tlp.enable = true;

  # Video drivers
  hardware.bumblebee.enable = true;
}
