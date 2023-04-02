{ pkgs, ... }:
{
  home.sessionVariables = {
    TERMINAL = "foot";
  };
  programs.foot = {
    enable = true;
    settings = {
      main = {
        title = "Foot";
        term = "foot";

        # font = "Fira Code:size=12";
        dpi-aware = "yes";
      };

      mouse = {
        hide-when-typing = "yes";
      };
    };
  };
}