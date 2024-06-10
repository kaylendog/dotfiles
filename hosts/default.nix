{
  nixpkgs,
  self,
  ...
}@inputs: let
  inherit (self) inputs;
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs;
      inherit self;
    };
    users.kaylen = {
      imports = [../home];
    };
  };
in {
  kaylbox = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      { networking.hostName = "kaylbox"; }
      ./kaylbox
      { inherit home-manager; }
      ../modules/system
      ../modules/nvidia
    ];
    specialArgs = {
      inherit inputs;
    };
  };
}
