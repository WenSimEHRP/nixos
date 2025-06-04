# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan
    ./hardware-configuration.nix
    # <nixos-hardware/lenovo/legion/16irx8h>

    # Import modular configurations
    ./modules/system.nix
    ./modules/desktop.nix
    ./modules/users.nix
    ./modules/packages.nix
    ./modules/ime-fonts.nix
    ./modules/sway.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken.
  system.stateVersion = "24.11";
}
