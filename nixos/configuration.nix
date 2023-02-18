{ config, lib, pkgs, inputs, user, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../modules/kmonad.nix
  ];

  nixpkgs = {
    config = {
      allowBroken = true;
      allowUnfree = true;
    };
  };

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 5;
    };
    efi.canTouchEfiVariables = true;
    timeout = 1;
  };

  networking = {
    hostName = "t14_jdsee";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Amsterdam";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  security = {
    polkit.enable = true; # required to setup sway with HomeManager
    pam.services.swaylock = {
      text = "auth include login";
    };
  };

  services = {
    blueman.enable = true;
    openssh.enable = true;
    pcscd.enable = true;

    logind.lidSwitch = "suspend";

    xserver = {
      enable = true;
      libinput = {
        enable = true; # enable touchpad
        touchpad = {
          disableWhileTyping = true;
          naturalScrolling = true;
        };
      };
      desktopManager = {
        xterm.enable = false;
        xfce.enable = true;
      };
      videoDrivers = [
        "displaylink"
        "modsetting"
      ];
      displayManager = {
        sessionCommands = ''
          ${lib.getBin pkgs.xorg.xrandr}/bin/xrandr --setprovideroutputsource 2 0
        '';
      };
      layout = "us,de";
      xkbOptions = "grp:alt_space_toggle,altwin:swap_alt_win";
    };

    # TODO
    # jack = {
    #   jackd.enable = true;
    #   alsa.enable = false;
    #   loopback = {
    #     enable = true;
    #   };
    # };

    # TODO
    # kmonad = {
    #   enable = false;
      # configfiles = [ ../home/kmonad/config.kbd ];
    # };
  };

  systemd.services = {
    keyd = {
      description = "key remapping daemon";
      requires = [ "local-fs.target" ];
      after = [ "local-fs.target" ];
      wantedBy = [ "sysinit.target" ];
      unitConfig = {
        Type = "simple";
      };
      serviceConfig = {
        ExecStart = "/usr/bin/keyd";
      };
    };
  };

  environment.etc = {
    "keyd/default.conf".source = ../home/keyd/config/keyd/default.conf;
  };

  fonts.fonts = with pkgs; [
    font-awesome
    (nerdfonts.override {
      fonts = [
        "Hack"
      ];
    })
  ];

  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixFlakes;
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      warn-dirty = false
    '';
  };

  sound = {
    enable = true;
    mediaKeys = {
      enable = true;
    };
  };

  hardware = {
    pulseaudio.enable = true;
    bluetooth.enable = true;

    opengl = {
      enable = true;
      driSupport = true;
    };
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "jackaudio"
      "camera"
      "networkManager"
      "input"
      "uinput"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
    ];
  };

  environment = {
    variables = {
      TERMINAL = "alacritty";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    systemPackages = with pkgs; [
      tmux
      git
      curl
      wget

      ((vim_configurable.override { }).customize {
        name = "vim";
        vimrcConfig = {
          packages.myplugins = with pkgs.vimPlugins; {
            start = [ vim-nix vim-lastplace ];
            opt = [ ];
          };
          customRC = ''
            set nu
            set relativenu
            set incsearch
            set nocompatible
            backspace=indent,eol,start
            syntax on
          '';
        };
      })
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs = {
    light.enable = true;
    sway.enable = true;
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "gtk2";
    enableSSHSupport = true;
  };

  system.stateVersion = "22.05";
}
