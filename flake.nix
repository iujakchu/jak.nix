{
  description = "jak home flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = {
    self,
    nixpkgs,
    hyprland,
    neovim-nightly-overlay,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {allowUnfree = true;};
    };
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      art = lib.nixosSystem {
        inherit system;
        modules = [
          {nixpkgs.overlays = [neovim-nightly-overlay.overlay];}
          hyprland.nixosModules.default
          {programs.hyprland.enable = true;}
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.yann = import ./home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
        specialArgs = inputs;
      };
    };
  };
}
