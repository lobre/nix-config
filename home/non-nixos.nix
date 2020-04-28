{ config, pkgs, ... }:

{
  # To correct missing behaviors on non NixOS systems
  programs.bash.profileExtra = ''
      # Load nix if not already loaded
      [[ ":$PATH:" != *":$HOME/.nix-profile/bin:"* ]] && source $HOME/.nix-profile/etc/profile.d/nix.sh

      # Set xdg path that is normally set in NixOS with /etc/profile
      [[ ":$XDG_DATA_DIRS:" != *":$HOME/.nix-profile/share:"* ]] && export XDG_DATA_DIRS="$HOME/.nix-profile/share:$XDG_DATA_DIRS"
      [[ ":$XDG_CONFIG_DIRS:" != *":$HOME/.nix-profile/etc/xdg:"* ]] && export XDG_CONFIG_DIRS="$HOME/.nix-profile/etc/xdg:$XDG_CONFIG_DIRS"
  '';
  programs.zsh.profileExtra = config.programs.bash.profileExtra;

  # To fix glibc locale bug (https://github.com/NixOS/nixpkgs/issues/38991)
  home.sessionVariables.LOCALE_ARCHIVE_2_27 = "${pkgs.glibcLocales}/lib/locale/locale-archive";

  # Fix Open GL issues by forcing mesa drivers
  nixpkgs.overlays = [
    (
      self: super: {
        alacritty = super.writeScriptBin "alacritty" ''
          #!${super.stdenv.shell}
          export LIBGL_DRIVERS_PATH=${super.mesa_drivers}/lib/dri
          export LD_LIBRARY_PATH=${super.mesa_drivers}/lib:$LD_LIBRARY_PATH
          exec ${super.alacritty}/bin/alacritty "$@"
        '';
      }
    )
    (
      self: super: {
        picom = super.writeScriptBin "picom" ''
          #!${super.stdenv.shell}
          export LIBGL_DRIVERS_PATH=${super.mesa_drivers}/lib/dri
          export LD_LIBRARY_PATH=${super.mesa_drivers}/lib:$LD_LIBRARY_PATH
          exec ${super.picom}/bin/picom "$@"
        '';
      }
    )
  ];

}
