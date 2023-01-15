{ config, pkgs, ... }:

{
  networking.hostName = "kimsufi";

  # For bios (replace with disk where grub installed)
  boot.loader.grub.device = "/dev/sda";

  imports = [
    ./hardware-configuration.nix
    ../../roles/nixos/base
    ../../roles/nixos/server
  ];

  system.stateVersion = "21.11";
}
