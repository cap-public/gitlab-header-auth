with import <nixpkgs> {};
stdenv.mkDerivation rec {
  name = "env";
  env = buildEnv { name = name; paths = buildInputs; };
  buildInputs = [
    elixir_1_10
    nodejs
    inotify-tools
    watchexec
  ];
}
