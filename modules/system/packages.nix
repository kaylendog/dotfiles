{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    git
    curl
    btrfs-progs
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

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
}
