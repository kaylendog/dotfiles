{
  description = "the kaylen dog";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/24.05";

    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = import ./hosts inputs;
  };
}
