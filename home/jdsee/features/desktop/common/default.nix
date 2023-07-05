{ pkgs, lib, outputs, ... }:
{
  imports = [
    ./discord.nix
    ./firefox.nix
    # ./flameshot.nix
    ./font.nix
    ./gtk.nix
    ./gtkgreet.nix
    ./imv.nix
    ./intellij.nix
    ./obs.nix
    ./pavucontrol.nix
    ./pulsemixer.nix
    ./qt.nix
    ./rbw.nix
    ./typesetting.nix
    ./xcape.nix
  ];

  xdg.mimeApps.enable = true;
  home.packages = with pkgs; [
    cinnamon.nemo-with-extensions
    shotman
    libreoffice

    # communication
    thunderbird
    signal-desktop

    # research
    obsidian
    zotero
  ];
}
