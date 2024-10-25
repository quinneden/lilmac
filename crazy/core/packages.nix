{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    asahi-bless
    bat
    btrfs-progs
    eza
    git
    hfsprogs
    libnotify
    rclone
    ripgrep
    wget
    # dotnet-sdk
    # ntfs3g
  ];

  # programs.java = {
  #   enable = true;
  #   package = pkgs.jdk22;
  # };

  # environment.sessionVariables = {
  #   DOTNET_ROOT = "${pkgs.dotnet-sdk}";
  #   _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd";
  # };
}
