{pkgs, ...}: {
  users = {
    users = {
      kaylen = {
        shell = pkgs.zsh;
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" ];
      };
    };
  };
}
