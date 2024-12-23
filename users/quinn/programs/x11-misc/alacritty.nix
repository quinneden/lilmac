{ flakeConfig, ... }:
{
  programs.alacritty = {
    enable = true;

    settings = {
      # flakeConfig.colorscheme already follows the alacritty colors spec (mostly).
      # ignoring some meta info such as `scheme`.
      colors = with flakeConfig.colorscheme; {
        inherit
          primary
          normal
          bright
          ;

        cursor = {
          text = bright.white;
          cursor = bright.black;
        };
      };

      cursor = {
        style.shape = "Beam";
      };

      window = {
        opacity = 0.95;
        padding = rec {
          x = 8;
          y = x;
        };
      };

      font =
        let
          offset = 0;
        in
        {
          size = 10.5;
          offset.y = offset;
          glyph_offset.y = if offset == 0 then 0 else offset;

          normal = {
            family = "CaskaydiaCove Nerd Font";
            style = "Regular";
          };

          italic = {
            family = "CaskaydiaCove Nerd Font";
            style = "Italic";
          };
        };
    };
  };
}
