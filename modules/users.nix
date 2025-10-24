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
  };
  users.users.guest = {
    isNormalUser = true;
    description = "Guest";
    extraGroups = [
      "networkmanager"
    ];
    password = "a";
  };
  systemd.tmpfiles.rules = [
    "D! /home/guest 0700 guest users - -"
  ];
}
