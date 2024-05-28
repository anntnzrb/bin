_: {
  perSystem = { config, pkgs, ... }: {
    devShells.default = pkgs.mkShell {
      name = "bin-devshell";
      meta.description = "~/bin development environment";

      packages = with pkgs; [
        nodePackages.bash-language-server
        shellcheck
        shfmt
      ] ++ [ config.treefmt.build.wrapper ];
    };
  };
}
