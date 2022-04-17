{ lib, inputs, system, home-manager, user, ... }:

{
  world = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit user inputs;
    };
    modules = [
      ./configuration.nix
      home-manager.nixosModules.home-manager {
        home-manager = {
	  useGlobalPkgs = true;
	  useUserPackages = true;
	  extraSpecialArgs = {
	    inherit user;
	  };
	  users.${user} = {
	    imports = [(import ./home.nix)];
	  };
	};
      }
    ];
  };
}