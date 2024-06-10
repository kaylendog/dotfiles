{pkgs, inputs, ...}: {
  nixpkgs.config.allowUnfree = false;
  home.packages = with pkgs; [];

  programs.neovim.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      vim = "nvim";
    };

    zplug = {
      enable = true;      
      plugins = [
        { name = "marlonrichert/zsh-autocomplete"; }
        { name = "zsh-users/zsh-syntax-highlighting"; }
        { name = "zsh-users/zsh-completions"; }
      ];
    };
  };

  # https://starship.rs/installing/#nix
  programs.starship.enable = true;
}
