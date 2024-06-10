{pkgs, inputs, ...}: {
  nixpkgs.config.allowUnfree = false;
  home.packages = with pkgs; [];

  # https://starship.rs/installing/#nix
  programs.starship.enable = true;
}
