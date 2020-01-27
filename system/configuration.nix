{ config, pkgs, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;
  # No need for predictable names as I usually only have one ethernet and one wireless interfaces
  networking.usePredictableInterfaceNames = false;

  # Enable docker
  virtualisation.docker.enable = true;

  # Internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "fr-bepo";
    defaultLocale = "en_GB.UTF-8";
  };

  # Timezone
  time.timeZone = "Europe/Paris";

  # Packages installed in system profile
  environment.systemPackages = with pkgs; [
    acpilight
    curl
    firefox 
    git
    open-vm-tools
    pavucontrol
    unzip
    vim_configurable 
    wget 
  ];

  # Programs
  programs.dconf.enable = true;
  programs.evince.enable = true;
  programs.file-roller.enable = true;
  programs.zsh.enable = true;

  # Services
  services.gnome3.sushi.enable = true;
  services.pantheon.files.enable = true;

  # Sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Allow packages from unfree channels
  nixpkgs.config.allowUnfree = true;
}
