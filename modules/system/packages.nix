{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    curl
    btrfs-progs
  ];
  programs.zsh.enable = true;
  programs.git.enable = true;
}
