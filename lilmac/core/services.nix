{
  lib,
  pkgs,
  ...
}:
{
  programs = {
    dconf.enable = true;
    hyprland.enable = true; # enable system level hyprland settings.
  };

  services = {
    libinput.enable = true;

    openssh = {
      enable = true;

      settings = {
        PasswordAuthentication = true;
        PermitRootLogin = "yes";
      };
    };

    displayManager = {
      sddm = {
        enable = true;
      };
    };

    desktopManager = {
      plasma6 = {
        enable = true;
      };
    };

    xserver = {
      enable = true;

      windowManager.awesome = {
        enable = true;

        luaModules = lib.attrValues {
          inherit (pkgs.luaPackages)
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
