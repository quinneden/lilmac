{
  description = "Here's my effort to keep myself on nixos while having a comfy and crazy workstation";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-f2k.url = "github:moni-dz/nixpkgs-f2k";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    cutefetch.url = "github:alphatechnolog/cutefetch";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    apple-cursor-src = {
      url = "github:ful1e5/apple_cursor";
      flake = false;
    };

    decay-discord-src = {
      url = "github:decaycs/decay-discord";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    config = import ./config.nix;
  in
    with config; {
      nixosConfigurations."${hostname}" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          inherit inputs;
          flakeConfig = config;
        };

        modules =
          [mainModule]
          ++ (
            if !config.modules.homeManager.enable
            then []
            else
              (with inputs; [
                home-manager.nixosModules.home-manager
                (mainModule + /home-manager.nix)
              ])
          );
      };
    };
}
