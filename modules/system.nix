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

  # for obs
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';
  security.polkit.enable = true;

  # networking
  # services.mihomo = {
  #   enable = true;
  #   webui = pkgs.metacubexd;
  #   tunMode = true;
  #   configFile = "/etc/akua.yaml";
  # };

  networking.firewall = {
    enable = false;
    trustedInterfaces = [ "tunrouted" ];
  };

  networking.hosts = {
    "10.254.98.1" = [ "captiveportal-login.vpl.ca" ];
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
