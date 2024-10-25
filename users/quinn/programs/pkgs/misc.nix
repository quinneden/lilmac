{
  pkgs,
  inputs,
  flakeConfig,
  ...
}:
let
  shellscripts = inputs.nix-shell-scripts.packages.${flakeConfig.system}.default;
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
