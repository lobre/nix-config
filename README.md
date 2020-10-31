# nix-home

NixOS and Home Manager configurations and instructions.

![Screenshot](screenshot.png)

## Table of contents

- Check [this page](docs/nixos-install.md) to know how to install NixOS with a ZFS filesystem.
- Check [this page](docs/home-manager.md) for using home-manager to apply user configurations.

## Non NixOS setup

If you want to apply the user configurations without having NixOS as the operating system, you will also have to follow the [home-manager documentation](docs/home-manager.md).

### i3

In the user configuration, i3 is launched using the `~/.xsession` user file. That means the display manager should have an option to run the default user session for this `~/.xsession` file to be taken into account. Here is an example of configuration to create a default user session entry. You need to create a file `/usr/share/xsessions/default.desktop` as follows.

```
[Desktop Entry]
Name=Xsession
Comment=This runs the default user session
Exec=default
Icon=
```

### Sway

The only easy way to start sway is unfortunaty to call it from tty. On top of that, `nixGL` is needed on non NixOS.

```
nixGL sway
```

## Colors

Colors in terminal emulators were first standardized using some ANSI escape sequences. See https://en.wikipedia.org/wiki/ANSI_escape_code.

The original specification supported only 8 colors but terminal emulators rapidly started to support 16, 256 and even the complete range of colors (called "true colors"). However, most terminal utilities use only the main 16 colors.

However, in my setup, I don't deal only with terminal emulators. I also have proper graphical applications that don't have such restrictions.

To have a consistent theming accross all apps, I was looking for a proper color palette. Because of the 16 colors restrictions of terminal emulators, I first thought it was a good idea to restrict myself to only use those 16 colors in all my apps (whether they were terminals or not). But that was a mistake. Terminal colors are for, well, terminals. They will help to colorize code. But for a full desktop environment, I actually needed more colors. More specifically, I needed many different shades for a single color.

So I changed my system to have something that looks like the color palette of [tailwindcss](https://tailwindcss.com/docs/customizing-colors#default-color-palette).

This is much more convenient. Wherever I need colors, I just import `home/gui/colors.nix` and use whatever I need. The 16 colors of my terminal are also drawn from this palette.

In the end, I have a set of color to keep things consistent, but not as many as "truecolors", and not as few as terminal ANSI colors.
