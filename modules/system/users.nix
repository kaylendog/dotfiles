{pkgs, ...}: {
  users = {
    mutableUsers = false;
    users = {
      kaylen = {
        shell = pkgs.zsh;
        extraGroups = [ "wheel" "networkmanager" ];
      };
    };
  };
}
