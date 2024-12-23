{
  pkgs,
  lib,
  flakeConfig,
  ...
}:
let
  shellAliases =
    let
      eza = lib.getExe pkgs.eza;
      bat = lib.getExe pkgs.bat;
    in
    {
      ls = "${eza} --icons";
      la = "ls -la";
      tree = "ls --tree";
      cat = "${bat} --paging=never --style=plain --theme=base16";
      cd = "z";
      code = "code --disable-gpu";
      neofetch = "${pkgs.fastfetch}/bin/flashfetch";
      tmux = "tmux -2";
    };
in
{
  programs = {
    command-not-found = {
      enable = true;
    };

    zsh = {
      enable = true;
      enableCompletion = true;

      inherit shellAliases;

      autocd = true;
      syntaxHighlighting.enable = true;

      autosuggestion =
        let
          inherit (flakeConfig) colorscheme;
        in
        {
          enable = true;
          highlight = "fg=${colorscheme.bright.black}";
        };
    };

    bash = {
      enable = true;

      inherit shellAliases;

      bashrcExtra = ''
        source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
        printf '\033[6 q'
        export TERM=tmux-256color
      '';
    };

    zoxide = {
      enable = true;
      enableBashIntegration = true;
    };

    starship = {
      enable = true;
      enableBashIntegration = true;

      settings = {
        add_newline = false;
        format = "$directory$git_branch$git_status$nix_shell$character";

        directory =
          let
            inherit (flakeConfig.colorscheme) accents;
          in
          {
            style = accents.secondary;
            read_only = "";
            read_only_style = "yellow";
            home_symbol = flakeConfig.user.name;
          };

        nix_shell = {
          symbol = "";
          unknown_msg = "(im)pure?";
        };

        git_branch = {
          symbol = "";
          format = "on [$symbol$branch]($style) ";
        };

        character =
          let
            value = "[|](black)";
          in
          {
            disabled = false;
          }
          // lib.fold (key: acc: acc // { "${key}" = "${value}"; }) { } [
            "success_symbol"
            "error_symbol"
            "vimcmd_symbol"
            "vimcmd_replace_one_symbol"
            "vimcmd_replace_symbol"
            "vimcmd_visual_symbol"
          ];
      };
    };
  };
}
