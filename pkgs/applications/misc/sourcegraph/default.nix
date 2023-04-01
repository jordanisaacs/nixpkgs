{ stdenv
, lib
, fetchurl
, autoPatchelfHook
, unzip
}:
let
  name = "sourcegraph";
  version = "2023.03.23+209542.7216ba_linux_amd64";
in
stdenv.mkDerivation {
  inherit name;

  src = fetchurl {
    url = "https://storage.googleapis.com/sourcegraph-app-releases/2023.03.23+209542.7216ba/${name}_${version}.zip";
    hash = "sha256-XeVXnQrKZ+Itd6jrlYEPxNuAhOt9q3gLNCxywrX6Kxs=";
  };

  sourceRoot = ".";

  nativeBuildInputs = [
    autoPatchelfHook
    unzip
  ];

  buildInputs = [
    stdenv.cc.cc.lib
  ];

  installPhase = ''
    install -m755 -D ${name} $out/bin/${name}
  '';


  meta = with lib; {
    platforms = platforms.linux;
  };
}
