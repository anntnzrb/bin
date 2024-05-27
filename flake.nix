{
  description = "annt's ~/bin";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # src tree fmt
    treefmt-nix.url = "github:numtide/treefmt-nix/main";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";

    # misc
    flake-parts.url = "github:hercules-ci/flake-parts/main";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ inputs.treefmt-nix.flakeModule ];
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];

      perSystem = { pkgs, ... }: {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [ just ];
        };

        packages.notflix = pkgs.callPackage ./notflix { };

        treefmt.config = {
          projectRootFile = "flake.nix";
          programs = {
            nixpkgs-fmt.enable = true;
            prettier.enable = true;
          };

          settings.formatter.shfmt = {
            command = pkgs.shfmt;
            includes = [ "*.sh" ];
            options = [
              "--simplify"
              "--binary-next-line"
              "--indent"
              "4"
            ];
          };
        };
      };
    };
}
