{pkgs, ...}: {
  users = {
    mutableUsers = false;
    users = {
      kaylen = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" ];
      };
    };
  };
}
