{
  description = "ivopiro's flake.";

  inputs = {

    # Must
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Extra
    gslapper.url = "github:Nomadcxx/gSlapper"; # live wallpapers
  };

  outputs = inputs@{nixpkgs, home-manager, ...}: 
  {
    nixosConfigurations = {
      ivo-nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [ 
            ./configuration.nix 
            # import home-manager
            home-manager.nixosModules.home-manager
            # config home-manager
            {
              home-manager.useGlobalPkgs = true; # 
              home-manager.useUserPackages = true; # if unset, any packages will be installed at ~/.nix-profile
              home-manager.extraSpecialArgs = { 
                inherit inputs; 
                dotfiles = {
                  dir = "/home/ivopiro/.dotfiles/dotfiles";
                };
              };
              home-manager.backupFileExtension = "backup"; # for moving existing dotfiles
              home-manager.users.ivopiro = ./home.nix;
            }
          ];
      };
    };
  };
}