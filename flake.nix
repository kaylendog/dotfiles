{
  description = "the kaylen dog";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/24.11";

    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = import ./hosts inputs;
  };
}
