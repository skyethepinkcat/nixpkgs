{
  ffmpeg,
  mediainfo,
  lib,
  stdenv,
  rustPlatform,
  fetchPnpmDeps,
  pnpm_11,
  pnpmConfigHook,
  cargo-tauri,
  glib-networking,
  nodejs,
  openssl,
  pkg-config,
  webkitgtk_4_1,
  wrapGAppsHook4,
  fetchFromGitHub,

}:

let
  pnpm = pnpm_11;
in
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "mosaic-cli";
  version = "0.1.7";
  cargoHash = "sha256-NcB32e+bW8Fg267T+VPtgTHyGltzvlg+8FWc0iRN2og=";
  src = fetchFromGitHub {
    owner = "mosaicvideo";
    repo = "mosaic";
    rev = "v${finalAttrs.version}";
    hash = "sha256-qGA4quUoQKfkegyUiq+hHP1xtlA3RAoFuUuFJ47l/08=";
  };
  pnpmDeps = fetchPnpmDeps {
    pname = "${finalAttrs.pname}-${finalAttrs.version}-npm-deps";
    fetcherVersion = 4;
    inherit pnpm;
    inherit (finalAttrs) src;
    hash = "sha256-rYBcAIjWZkYs/Wbz78Vn2cTm2LRZQ1fCj/mQkjYBftQ=";
  };
  nativeBuildInputs = [
    pnpm
    pnpmConfigHook
    nodejs
    pkg-config
    ffmpeg
    mediainfo
  ];

  buildInputs = [
    ffmpeg
    mediainfo
  ]
  ++ lib.optionals stdenv.hostPlatform.isLinux [
  ];
  # Set our Tauri source directory
  cargoRoot = "mosaic-cli";
  # And make sure we build there too
  buildAndTestSubdir = finalAttrs.cargoRoot;

})
