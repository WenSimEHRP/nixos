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
}
