{ pkgs ? (
    let
      inherit (builtins) fetchTree fromJSON readFile;
      inherit ((fromJSON (readFile ./flake.lock)).nodes) nixpkgs gomod2nix;
    in
    import (fetchTree nixpkgs.locked) {
      overlays = [
        (import "${fetchTree gomod2nix.locked}/overlay.nix")
      ];
    }
  )
}:

pkgs.buildGoApplication {
  pname = "lazygit";
  version = "1.3.3.7";
  pwd = ./.;
  src = ./.;
  modules = ./gomod2nix.toml;
  checkPhase = ''
  echo skip tests
  '';
}
