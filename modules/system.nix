{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Core system settings
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  time.timeZone = "America/Vancouver";
  i18n.defaultLocale = "en_CA.UTF-8";
}
