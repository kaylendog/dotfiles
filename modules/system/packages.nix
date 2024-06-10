{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    curl
    btrfs-progs
  ];
  programs.git.enable = true;
}
