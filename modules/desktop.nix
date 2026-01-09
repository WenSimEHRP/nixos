{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Enable the X11 windowing system
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  # services.displayManager.gdm.enable = true;
  services.desktopManager.plasma6.enable = true;
  # services.desktopManager.gnome.enable = true;
  # environment.gnome.excludePackages = with pkgs; [ gnome-tour gnome-user-docs ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable sound with pipewire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable CUPS to print documents
  services.printing.enable = true;
}
