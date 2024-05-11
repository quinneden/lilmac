{ flakeConfig, lib, pkgs, ... }:

{
  home.activation.installAetherShell = with flakeConfig.user; let
    # maybe just to make it more clear ig
    username = name;
    git = lib.getExe pkgs.git;
  in ''
    if ! test -d ~/.config/awesome; then
      ${git} clone https://github.com/alphatechnolog/aether-shell.git --recursive \
        ~/.config/awesome || true

      # check if it cloned successfully, it shouldn't fail if so (e.g: no internet)
      if test -d ~/.config/awesome; then
        chown -R ${username} ~/.config/{aether-shell/awesome}
      fi
    fi
  '';
}
