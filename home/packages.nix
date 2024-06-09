{pkgs, inputs, ...}: {
  nixpkgs.config.allowUnfree = false;
  home.packages = with pkgs; [
    vim
    zsh
  ];

  programs.zsh = {
    enable = true;
    shellAliases = {
      vim = "nvim";
    }
  }
}
