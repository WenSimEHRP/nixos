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
  networking.hostName = "hotbars";
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

  # networking.firewall = {
  #   enable = false;
  #   trustedInterfaces = [ "tunrouted" ];
  # };

  networking.hosts = {
    # "10.254.98.1" = [ "captiveportal-login.vpl.ca" ];
    "209.52.108.127" = [ "captiveportal-login.vpl.ca" ];
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

  # copied from https://github.com/NixOS/nixpkgs/issues/489947
  hardware.nvidia = {
    open = true; # YOU CAN SET THIS TO FALSE AND IT WILL ALSO BUILD
    nvidiaSettings = true;

    # Apply CachyOS kernel 6.19 patch to NVIDIA latest driver
    package =
      let
        base = config.boot.kernelPackages.nvidiaPackages.latest;
        cachyos-nvidia-patch = pkgs.fetchpatch {
          url = "https://raw.githubusercontent.com/CachyOS/CachyOS-PKGBUILDS/master/nvidia/nvidia-utils/kernel-6.19.patch";
          sha256 = "sha256-YuJjSUXE6jYSuZySYGnWSNG5sfVei7vvxDcHx3K+IN4=";
        };

        # Patch the appropriate driver based on config.hardware.nvidia.open
        driverAttr = if config.hardware.nvidia.open then "open" else "bin";
      in
      base
      // {
        ${driverAttr} = base.${driverAttr}.overrideAttrs (oldAttrs: {
          patches = (oldAttrs.patches or [ ]) ++ [ cachyos-nvidia-patch ];
        });
      };

    powerManagement.enable = true;

    modesetting.enable = true;
    dynamicBoost.enable = lib.mkForce true;
  };
}
