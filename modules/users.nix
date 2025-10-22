{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Define user account
  users.users.jeremyg = {
    isNormalUser = true;
    description = "Jeremy Gao";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };
  users.users.tester = {
    isNormalUser = true;
    description = "Tester";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    hashedPassword = "";
  };
  users.users.guest = {
    isNormalUser = true;
    description = "Guest - PWD is 'a'";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    password = "a";
  };
  systemd.tmpfiles.rules = [
    "D! /home/guest 0700 guest users - -"
  ];
}
