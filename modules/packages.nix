{
  config,
  lib,
  pkgs,
  ...
}:

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

    fish
    vscode-fhs
    alacritty
    nixfmt-rfc-style

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

    qq
    wechat-uos
    aseprite

    megacmd

    (pkgs.runCommand "openttd-jgrpp" { nativeBuildInputs = [ pkgs.makeWrapper ]; } ''
      mkdir -p $out/bin
      makeWrapper ${pkgs.openttd-jgrpp}/bin/openttd $out/bin/openttd-jgrpp --argv0 openttd
    '')
  ];

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}
