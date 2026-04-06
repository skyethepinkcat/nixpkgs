{
  buildGoModule,
  fetchFromGitHub,
  lib,
  tree-sitter,
  stdenv,
  nodejs,
  go,
  gcc,
libcxx,
  ...
}:
buildGoModule (finalAttrs: rec {
  pname = "rad";
  version = "0.9.2";
  src = fetchFromGitHub {
    owner = "amterp";
    repo = "rad";
    tag = "v${version}";
    hash = "sha256-+sB+Nes+ir20HG86bYTYeSfcufk7XGEuizE2UlLvOL4=";
  };
  vendorHash = "sha256-+ujWH3JrAWbFWQcRTLLBBm1/cAXwPPdR/7FzKRWMfm4=";
  buildInputs = [
    tree-sitter
    stdenv
    nodejs
    go
    gcc
    libcxx
  ];

  subPackages = [
    "rts"
  ];

  postBuild =
    # bash
    ''
      mkdir -p $out/bin
      mv bin/* $out/bin/
    '';

  meta = {
    description = "A Scripting Language to make Modern CLI Scripts Easy";
    homepage = "https://github.com/amterp/rad";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ skyethepinkcat ];
  };
})
