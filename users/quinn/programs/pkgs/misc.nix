{
  pkgs,
  inputs,
  system,
  ...
}:
let
  shellscripts = inputs.nix-shell-scripts.packages.${system}.default;
in
{
  home.packages = with pkgs; [
    # cutefetch
    # spotify
    desmume
    eza
    feh
    htop
    maim
    nexusfetch
    pavucontrol
    pfetch
    psmisc
    rofi
    shellscripts
    webx
  ];
}
