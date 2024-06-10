{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    git
    curl
    btrfs-progs
  ];
}
