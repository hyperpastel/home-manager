{
  description = "Home Manager configuration of hyperpastel";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    scripts = {
        url = "github:hyperpastel/scripts";
        inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations."v@teyvat" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs.flake-inputs = inputs;
        modules = [ ./hosts/teyvat ];
      };

      homeConfigurations."v@darksea" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs.flake-inputs = inputs;
        modules = [ ./hosts/darksea ];
      };

    };
}
