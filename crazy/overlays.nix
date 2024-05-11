{inputs, ...}: {
  nixpkgs.overlays = let
    fontsOverlays = _: prev: {
      material-symbols = prev.callPackage ./pkgs/material-symbols.nix {};

      nerdfonts = prev.nerdfonts.override {
        fonts = ["JetBrainsMono" "IosevkaTerm" "Iosevka" "NerdFontsSymbolsOnly"];
      };
    };

    awmOverlay = final: _: let
      inherit (final) system;
      inherit (inputs) nixpkgs-f2k;
    in
      with nixpkgs-f2k.packages.${system}; {
        inherit picom-git;
        awesome = awesome-luajit-git;
      };

    miscOverlays = _: prev: let
      inherit (prev) system;
      inherit (inputs) cutefetch;
    in {
      cutefetch = cutefetch.packages.${system}.default;

      discord-canary = prev.discord-canary.override {
        withOpenASAR = true;
        withVencord = true;
      };
    };
  in
    [
      inputs.nixpkgs-f2k.overlays.window-managers
      inputs.nixpkgs-f2k.overlays.compositors
    ]
    ++ [
      awmOverlay
      fontsOverlays
      miscOverlays
    ];
}
