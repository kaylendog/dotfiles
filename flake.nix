{
  description = "the kaylen dog";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos";

    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = import ./hosts inputs;
  };
}
