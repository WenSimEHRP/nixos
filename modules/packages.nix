{
  config,
  lib,
  pkgs,
  ...
}:

let
  openttd-jgrpp = pkgs.openttd-jgrpp.overrideAttrs (oldAttrs: {
    cmakeFlags = (oldAttrs.cmakeFlags or [ ]) ++ [
      "-DBINARY_NAME=openttd-jgrpp"
    ];
    meta = oldAttrs.meta // {
      mainProgram = "openttd-jgrpp";
    };
    # don't install the basesets after install
    postInstall = "";
    buildInputs = oldAttrs.buildInputs ++ [ pkgs.libGL ];
  });
  openttd = pkgs.openttd.overrideAttrs (oldAttrs: {
    buildInputs = oldAttrs.buildInputs ++ [ pkgs.libGL ];
  });
in
{
  # Firefox
  programs.firefox.enable = true;
  programs.git.enable = true;
  programs.kdeconnect.enable = true;
  services.flatpak.enable = true;
  programs.yazi.enable = true;
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  programs.obs-studio = {
    enable = true;
    package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    );
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };
  environment.systemPackages = with pkgs; [
    ffmpeg-full
    wget
    gitui
    fzf
    gh
    gnumake
    typst
    tinymist
    helix
    aria2
    audacity

    fish
    nushell
    vscode-fhs
    alacritty
    nixfmt
    direnv
    vlc
    zellij

    fd
    ripgrep
    bat
    fastfetch

    openttd
    openttd-jgrpp
    # openrct2
    # openloco
    lutris
    wineWowPackages.stable
    winetricks
    gamemode

    qq
    # wechat
    aseprite
    vesktop
    telegram-desktop
    mangohud
    lsfg-vk-ui
    lsfg-vk
    inkscape
    darktable

    megacmd
    hplip
    rclone

    google-chrome
    wl-clipboard

    # kde stuff
    # kdePackages.kcalc # Calculator
    # kdePackages.kcharselect # Tool to select and copy special characters from all installed fonts
    # kdePackages.kcolorchooser # A small utility to select a color
    # kdePackages.kolourpaint # Easy-to-use paint program
    # kdePackages.ksystemlog # KDE SystemLog Application
    # kdePackages.sddm-kcm # Configuration module for SDDM
    # kdiff3 # Compares and merges 2 or 3 files or directories
    # kdePackages.isoimagewriter # Optional: Program to write hybrid ISO files onto USB disks
    # kdePackages.partitionmanager # Optional Manage the disk devices, partitions and file systems on your computer
    # hardinfo2 # System information and benchmarks for Linux systems
    # wayland-utils # Wayland utilities
  ];

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    extraCompatPackages = [
      pkgs.proton-ge-bin
    ];
  };
}
