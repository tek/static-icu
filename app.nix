{}:
let
  static-haskell-nix = fetchTarball https://github.com/tek/static-haskell-nix/archive/icu.tar.gz;

  builder = import "${static-haskell-nix}/static-stack2nix-builder/default.nix" {
    normalPkgs = import "${static-haskell-nix}/nixpkgs.nix";
    stack2nix-output-path = "${./stack2nix-output.nix}";
    compiler = "ghc865";
    cabalPackageName = "static-icu";
  };

  static_package =
    with builder.haskell-static-nix_output.pkgs;
    haskell.lib.appendConfigureFlag (
      staticHaskellHelpers.addStaticLinkerFlagsWithPkgconfig builder.static_package [icu] "--libs icu-uc"
    ) "--ld-option=-Wl,--start-group --ld-option=-Wl,-lstdc++";
in {
  inherit static_package;
}
