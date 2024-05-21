{
  lib,
  pkgs,
  flakeConfig,
  ...
}: {
  programs = {
    dconf.enable = true;
  };

  services = {
    libinput.enable = true;
    openssh.enable = true;

    displayManager = {
      sddm.enable = true;
    };

    xserver = {
      enable = true;
      desktopManager.plasma5.enable = true;

      windowManager.awesome = {
        enable = true;

        luaModules = lib.attrValues {
          inherit
            (pkgs.luaPackages)
            lgi
            ldbus
            luadbi-mysql
            luaposix
            ;
        };
      };
    };
  };
}
