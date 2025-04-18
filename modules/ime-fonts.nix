{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Font configuration
  fonts.packages = with pkgs; [
    noto-fonts
    ibm-plex
    sarasa-gothic
  ];
  fonts.fontconfig.defaultFonts = {
    monospace = [ "Sarasa Fixed SC" ];
    sansSerif = [ "Sarasa UI SC" ];
    serif = [ "Noto Serif" ];
  };

  # Input method
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      kdePackages.fcitx5-configtool
      fcitx5-lua
      libsForQt5.fcitx5-qt
      fcitx5-rime
    ];
    fcitx5.waylandFrontend = true;
  };

  environment.sessionVariables = rec {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";
    GLFW_IM_MODULE = "ibus";
  };
}
