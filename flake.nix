{
  description = "Nix with flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    sops-nix.url = "github:Mic92/sops-nix";

    dot-secrets = {
      url = "git+ssh://git@github.com/HestHub/dot-secrets.git";
      flake = false;
    };
    # TODO https://github.com/cachix/git-hooks.nix?tab=readme-ov-file
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";
  };

  outputs = {
    self,
    nixpkgs,
    darwin,
    home-manager,
    zen-browser,
    sops-nix,
    ...
  } @ inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./modules/linux/configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.sharedModules = [
            sops-nix.homeManagerModules.sops
          ];

          home-manager.users.hest = import ./home/linux.nix;
          home-manager.extraSpecialArgs = {
            inherit inputs;
            system = "x86_64-linux";
          };
        }
      ];
    };

    darwinConfigurations.mbp = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./modules/darwin/system.nix
        ./modules/darwin/apps.nix

        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.sharedModules = [
            sops-nix.homeManagerModules.sops
          ];

          home-manager.users.hest = import ./home/darwin.nix;
          home-manager.extraSpecialArgs = {
            inherit inputs;
            system = "aarch64-darwin";
          };
        }
      ];
    };
  };
}
