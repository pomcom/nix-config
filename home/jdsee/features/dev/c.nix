{ inputs, lib, pkgs, config, outputs, ... }:
{
  home.packages = with pkgs; [
    cmake
    gcc
    gnumake
  ];
}
