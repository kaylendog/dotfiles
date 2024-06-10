{
  ...
}: {
  imports = [
    ./boot.nix
    ./packages.nix
    ./users.nix
  ];

  # DO NOT TOUCH
  system.stateVersion = "23.11";
}
