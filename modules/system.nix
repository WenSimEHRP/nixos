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
  i18n.defaultLocale = "en_CA.UTF-8";
  services.automatic-timezoned.enable = true;

  # networking
  services.mihomo = {
    enable = true;
    webui = pkgs.metacubexd;
    tunMode = true;
    configFile = "/etc/akua.yaml";
  };

  networking.firewall = {
    enable = false;
    trustedInterfaces = [ "tunrouted" ];
  };

  # mirror providers
  # nix.settings.substituters = [
  #   "https://mirrors.ustc.edu.cn/nix-channels/store"
  # ];

  # zram
  zramSwap.enable = true;

  # printers
  services.printing.enable = true;
  services.printing.drivers = [
    pkgs.gutenprint
    pkgs.hplipWithPlugin
    pkgs.splix
  ];
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
}
