{ config, pkgs, ... }:

{
  home.packages = [ pkgs.swaylock-effects ];
  programs.swaylock = {
    settings = {
      image = "$HOME/.config/wallpapers/monster-at-cafe.jpg";
      fade-in = 0.1;
      clock = true;
      font = config.fontProfiles.regular.family;
      font-size = 15;
      line-uses-inside = true;
      disable-caps-lock-text = true;
      indicator = true;
      indicator-caps-lock = true;
      indicator-radius = 40;
      indicator-idle-visible = true;
      indicator-y-position = 1000;

      # screenshots = true;
      # effect-blur = "20x3";
      # effect-scale = 0.3;
      # ring-color = "#${colors.base02}";
      # inside-wrong-color = "#${colors.base08}";
      # ring-wrong-color = "#${colors.base08}";
      # key-hl-color = "#${colors.base0B}";
      # bs-hl-color = "#${colors.base08}";
      # ring-ver-color = "#${colors.base09}";
      # inside-ver-color = "#${colors.base09}";
      # inside-color = "#${colors.base01}";
      # text-color = "#${colors.base07}";
      # text-clear-color = "#${colors.base01}";
      # text-ver-color = "#${colors.base01}";
      # text-wrong-color = "#${colors.base01}";
      # text-caps-lock-color = "#${colors.base07}";
      # inside-clear-color = "#${colors.base0C}";
      # ring-clear-color = "#${colors.base0C}";
      # inside-caps-lock-color = "#${colors.base09}";
      # ring-caps-lock-color = "#${colors.base02}";
      # separator-color = "#${colors.base02}";
    };
  };
}
