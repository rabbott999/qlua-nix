{ lib, pkgs, stdenv, fetchurl, perl, gfortran, zlib }:

stdenv.mkDerivation rec {
  pname = "openmpi";
  version = "3.1.6";
  src = with lib.versions; fetchurl {
    url = "https://download.open-mpi.org/release/open-mpi/v${major version}.${minor version}/openmpi-${version}.tar.bz2";
    sha256 = "0yfjl1kdy2xq0897vpcgy31630qphdin3mbl9mb1d9f25sc1s4sh";
  };

  nativeBuildInputs = [
    perl
  ];

  # Taken from nixpkgs openmpi
  postPatch = ''
    patchShebangs ./

    # Ensure build is reproducible
    ts=`date -d @$SOURCE_DATE_EPOCH`
    sed -i 's/OPAL_CONFIGURE_USER=.*/OPAL_CONFIGURE_USER="nixbld"/' configure
    sed -i 's/OPAL_CONFIGURE_HOST=.*/OPAL_CONFIGURE_HOST="localhost"/' configure
    sed -i "s/OPAL_CONFIGURE_DATE=.*/OPAL_CONFIGURE_DATE=\"$ts\"/" configure
    find -name "Makefile.in" -exec sed -i "s/\`date\`/$ts/" \{} \;
  '';

  buildInputs = [
    gfortran
    zlib
  ];

  configureFlags = [
    "--enable-mpi-thread-multiple"
    "--enable-mpi-fortran=yes"
    "--enable-mpi-compatibility"
  ];

}
