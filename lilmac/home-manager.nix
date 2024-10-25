{
  flakeConfig,
  inputs,
  system,
  ...
}:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";

    users = with flakeConfig; {
      "${user.name}" = import modules.homeManager.userConfig;
    };

    extraSpecialArgs = {
      inherit inputs flakeConfig system;
    };
  };
}
