{pkgs, inputs, ...}: {
  nixpkgs.config.allowUnfree = false;
  home.packages = with pkgs; [
    vim
    zsh
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      vim = "nvim";
    };

    plugins = [
      { name = "marlonrichert/zsh-autocomplete"; }
      { name = "zsh-users/zsh-syntax-highlighting"; }
      { name = "zsh-users/zsh-completions"; }
    ];
  };
  
  # https://starship.rs/installing/#nix
  programs.starship.enable = true;
}
