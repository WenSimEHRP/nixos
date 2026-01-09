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
  users.users.jeremy = {
    isNormalUser = true;
    description = "Jeremy Gnome";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
