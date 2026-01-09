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
}
