{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  pname = "libpcap";
  version = "0.8.3"; # Replace with the specific version you need

  src = pkgs.fetchurl {
    url = "https://www.tcpdump.org/release/libpcap-${version}.tar.gz";
    sha256 = "a972beaa11fb976ab474cb0035ac7816419cf9de16fb794f7aa87c51a7d5d481"; # Replace with the actual hash
  };

  buildInputs = [
    pkgs.glibc
    pkgs.flex
    pkgs.bison
  ];

#  configurePhase = ''
#    ./configure --prefix=$out --enable-shared
#  '';

#  installPhase = ''
#    make install
#  '';

  # Configure to enable shared libraries and disable static
  configureFlags = [ "--enable-shared" "--disable-static" ];

  buildPhase = ''
    make clean
    make
    # Explicitly build the shared library if it’s not created automatically
    gcc -shared -o libpcap.so.0.8 *.o -lc
  '';

  installPhase = ''
    mkdir -p $out/lib
    cp libpcap.so.0.8 $out/lib/
  '';
}
