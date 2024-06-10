{pkgs, ...}: {
  users = {
    mutableUsers = false;
    users = {
      kaylen = {
        shell = pkgs.zsh;
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" ];
      };
    };
  };
}
