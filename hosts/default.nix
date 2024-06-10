{
  nixpkgs,
  self,
  ...
}@inputs: let
  inherit (self) inputs;

  # modules
  nvidia = ../modules/nvidia;
  system = ../modules/system;
  hmModule = inputs.home-manager.nixosModules.home-manager;

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
      system
      nvidia
      hmModule
      { inherit home-manager; }
    ];
    specialArgs = {
      inherit inputs;
    };
  };
}
