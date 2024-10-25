{ inputs, ... }:
{
  imports =
    let
      inputsModules = with inputs; [
        nixos-apple-silicon.nixosModules.default
      ];

      modules = [
        ./core/configuration.nix
        ./overlays.nix
        ./output.nix
        ../misc/hardware-configuration.nix
      ];
    in
    [ ] ++ inputsModules ++ modules;
}
