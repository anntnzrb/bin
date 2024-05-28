{ inputs
, ...
}: {
  perSystem = { self', pkgs, ... }:
    let
      mkShellApp = { name, meta, runtimeInputs ? [ ] }: pkgs.writeShellApplication {
        inherit name meta runtimeInputs;
        text = builtins.readFile (inputs.self + "/src/" + name + ".sh");
      };
    in
    {
      packages = {
        default = self'.packages.heyhey;

        heyhey = mkShellApp {
          name = "heyhey";
          meta.description = "The sample 'heyhey' package";
        };

        notflix = mkShellApp {
          name = "notflix";
          runtimeInputs = with pkgs; [ curl gnugrep nodePackages_latest.peerflix ];
          meta.description = "notflix app";
        };
      };
    };
}
