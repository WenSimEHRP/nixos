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
  });
in
{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Firefox
  programs.firefox.enable = true;

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

    fish
    vscode-fhs
    rust-analyzer
    alacritty
    nixfmt-rfc-style
    direnv
    vlc

    fd
    ripgrep
    bat
    fastfetch

    openttd
    openttd-jgrpp
    openrct2
    openloco
    lutris
    wineWowPackages.stable
    thunderbird

    qq
    wechat-uos
    aseprite

    megacmd
    hplip
  ];

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}
