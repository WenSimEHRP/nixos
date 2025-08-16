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
  # Allow unfree packages
  # nixpkgs.config.allowUnfree = true;

  # Firefox
  programs.firefox.enable = true;
  programs.chromium.enable = true;

  # some KDE stuff
  programs.kdeconnect.enable = true;

  # Flatpak territory
  services.flatpak.enable = true;

  # quack quack
  programs.yazi.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
    wget
    git
    gitui
    fzf
    gh
    gnumake
    typst
    tinymist
    helix
    aria2
    rustup

    fish
    vscode-fhs
    rust-analyzer
    alacritty
    nixfmt-rfc-style
    direnv
    vlc
    zellij

    fd
    ripgrep
    bat
    fastfetch
    chromium

    openttd
    openttd-jgrpp
    openrct2
    openloco
    lutris
    wineWowPackages.stable
    thunderbird
    winetricks

    qq
    wechat-uos
    aseprite
    vesktop
    telegram-desktop
    mangohud
    lsfg-vk-ui
    lsfg-vk

    megacmd
    hplip

    # kde stuff
    kdePackages.kcalc # Calculator
    kdePackages.kcharselect # Tool to select and copy special characters from all installed fonts
    kdePackages.kcolorchooser # A small utility to select a color
    kdePackages.kolourpaint # Easy-to-use paint program
    kdePackages.ksystemlog # KDE SystemLog Application
    kdePackages.sddm-kcm # Configuration module for SDDM
    kdiff3 # Compares and merges 2 or 3 files or directories
    kdePackages.isoimagewriter # Optional: Program to write hybrid ISO files onto USB disks
    kdePackages.partitionmanager # Optional Manage the disk devices, partitions and file systems on your computer
    hardinfo2 # System information and benchmarks for Linux systems
    wayland-utils # Wayland utilities
    wl-clipboard # Command-line copy/paste utilities for Wayland
  ];

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}
