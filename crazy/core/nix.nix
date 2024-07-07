{pkgs, ...}: {
  nix = {
    package = pkgs.nixVersions.git;

    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
}
