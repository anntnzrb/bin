{
  inputs,
  ...
}:
{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem =
    { pkgs, ... }:
    {
      treefmt.config = {
        projectRootFile = ".git/config";
        programs = {
          nixfmt.enable = true;
          actionlint.enable = true;
          prettier.enable = true;

          deadnix = {
            enable = true;
            no-underscore = true;
          };

          statix = {
            enable = true;
            disabled-lints = [ "repeated_keys" ];
          };
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
}
