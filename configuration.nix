# Edit this configuration file to define what should be installed on your system. Help is available in the configuration.nix(5) man page, on https://search.nixos.org/options and in the NixOS manual 
# (`nixos-help`).

{ options, config, lib, pkgs, ... }:

let
  unstable = import <unstable> {
    config.allowUnfree = true;
  };
in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "m83"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  services.displayManager.sddm = {
    enable = true;
    wayland = {
      enable = true;
    };
  };

  services.fprintd.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  services.seatd.enable = true;

  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  # Enable NTP for accurate time
  services.timesyncd.enable = true;

  services.blueman.enable = true;

  programs = {
    hyprland.enable = true;
    hyprlock.enable = true;

    xfconf.enable = true;

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        exo
        mousepad
        thunar-archive-plugin
        thunar-volman
        tumbler
      ];
    };

    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        glibc
        dbus
        dbus-glib
        glib
        glib-networking
        gobject-introspection
        libpcap
        gcc-unwrapped.lib
        pacparser
        gcc-unwrapped.stdenv.cc.cc.lib
      ];
    };
  };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  systemd.user.services.dbus = {
    enable = true;
    wantedBy = [ "default.target" ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.truewebber = {
    isNormalUser = true;
    extraGroups = [ "wheel" "sudo" "networkmanager" "fingerprint" "audio" "video" "input" "docker" ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    ags
    alacritty
    baobab
    binutils
    brightnessctl
    btop
    btrfs-progs
    capitaine-cursors
    cava
    clang
    coreutils
    cpufrequtils
    curl
    dbus
    dpkg
    duf
    dunst
    unstable.eog
    expect
    eza
    fastfetch
    ffmpeg
    unstable.file-roller
    gcc
    git
    glib
    unstable.gnome-system-monitor
    google-chrome
    grim
    gsettings-qt
    gtk-engine-murrine
    htop
    hyprcursor
    hypridle
    imagemagick
    inetutils
    inxi
    iproute2
    jq
    killall
    kitty
    kubectx
    libappindicator
    libcap
    libnotify
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum
    (mpv.override {scripts = [mpvScripts.mpris];})
    networkmanager
    networkmanagerapplet
    unstable.nvtopPackages.full
    nwg-look
    oath-toolkit
    openssl
    openvpn
    pamixer
    pavucontrol
    pciutils
    playerctl
    polkit_gnome
    pyprland
    python311
    qt6ct
    qt6Packages.qtstyleplugin-kvantum
    qt6.qtwayland
    rofi-wayland
    slack
    slurp
    sublime3
    swappy
    swaynotificationcenter
    swww
    systemd
    unstable.go
    unstable.jetbrains.goland
    unzip
    vim
    wallust
    waybar
    wget
    wl-clipboard
    unstable.wlogout
    wofi
    xdg-user-dirs
    xdg-utils
    yad
    yt-dlp

#    adwaita-qt
    unstable.adwaita-icon-theme
  ];

  # FONTS
  fonts.packages = with pkgs; [
    noto-fonts
    fira-code
    noto-fonts-cjk-sans
    jetbrains-mono
    font-awesome
    terminus_font
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
  ];

  # Extra Portal Configuration
  xdg.portal = {
    enable = true;
    wlr.enable = false;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
  };

  virtualisation.docker.enable = true;

  environment.variables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    _JAVA_AWT_WM__NONEREPARENTING = 1;

    MOZ_ENABLE_WAYLAND = "1";      # Firefox on Wayland
    QT_QPA_PLATFORM = "wayland";   # Qt apps use Wayland
    GDK_BACKEND = "wayland";       # GTK apps use Wayland
    OZONE_PLATFORM = "wayland";    # Chromium-based apps (Chrome, Edge, Brave) use Wayland
    XDG_SESSION_TYPE = "wayland";  # Set session type to Wayland

    NIX_CC = "${pkgs.gcc}";
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.extraPackages = [ pkgs.mesa_drivers ];

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;

  hardware.bluetooth = {
    enable = true; # enables support for Bluetooth
    powerOnBoot = true; # powers up the default Bluetooth controller on boot
  };

  powerManagement = {
    enable = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config = {
    allowUnfree = true;
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}
