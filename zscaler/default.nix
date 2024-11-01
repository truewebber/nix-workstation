{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  pname = "zscaler";
  version = "1.0";

  # Path to the `.deb` file in your project directory
  src = ./zscaler.deb;

  # Define dependencies for unpacking `.deb` and running binaries
  buildInputs = [
#    pkgs.glibc
#    pkgs.dbus
#    pkgs.dbus-glib
#    pkgs.glib
#    pkgs.glib-networking
#    pkgs.gobject-introspection
#    pkgs.libpcap
#    pkgs.gcc-unwrapped.lib
#    pkgs.pacparser
    pkgs.dpkg  # Provides `dpkg` to unpack the .deb file
    # Add other dependencies here
  ];

  # Unpacking the `.deb` package
  unpackPhase = ''
    # Create a temporary directory and unpack the `.deb` contents
    mkdir -p unpacked
    dpkg-deb -x $src unpacked
  '';

  # Install binaries and libraries to `$out`
  installPhase = ''
    # Copy all contents of the unpacked directory to `$out`
    cp -R unpacked/ $out/
  '';

  # Optional: Define environment variables, if necessary
  #NIX_LD = "${pkgs.glibc}/lib/ld-linux-x86-64.so.2";
}
