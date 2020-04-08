{}:
let
  static-haskell-nix = fetchTarball https://github.com/tek/static-haskell-nix/archive/icu.tar.gz;
  pkgs = import "${static-haskell-nix}/nixpkgs.nix";

  stack2nix-script = import "${static-haskell-nix}/static-stack2nix-builder/stack2nix-script.nix" {
    inherit pkgs;
    stack-project-dir = toString ./.;
    hackageSnapshot = "2020-03-30T00:00:00Z";
  };
in {
  inherit stack2nix-script;
}
