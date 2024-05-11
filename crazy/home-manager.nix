{ flakeConfig, inputs, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users = with flakeConfig; {
      "${user.name}" = import modules.homeManager.userConfig;
    };

    extraSpecialArgs = {
      inherit inputs flakeConfig;
    };
  };
}
