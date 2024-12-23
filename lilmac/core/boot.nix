{ pkgs, ... }:
{
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = false;
        efiSysMountPoint = "/efi";
      };

      grub = {
        enable = true;
        efiSupport = true;
        efiInstallAsRemovable = true;
        useOSProber = true;
        device = "nodev";
      };
    };
  };

  hardware.asahi = {
    enable = true;
    extractPeripheralFirmware = true;
    peripheralFirmwareDirectory = builtins.fetchTarball {
      url = "https://qeden.me/fw/asahi-firmware-20241024.tar.gz";
      sha256 = "sha256-KOBXP/nA3R1+/8ELTwsmmZ2MkX3lyfp4UTWeEpajWD8=";
    };
  };
}
