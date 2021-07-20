{ pkgs, stdenv, fetchgit, openmpi, autoreconfHook, mpi }:

stdenv.mkDerivation rec {
  pname = "hdf5";
  version = "1.8.12";
  src = fetchgit {
    url = "https://usqcd.lns.mit.edu/git/LHPC/Public/alien-libs/hdf5.git";
    rev = "2f0dc3e98dda7fb7f2d114b8b71eadad85bb0048";
    sha256 = "0cssfddz6j0ya4mfq3awv2qc16k5gkl0vs1w0zh20q6icm52y21b";
  };

  buildInputs = [ pkgs.hostname ];

  nativeBuildInputs = [ autoreconfHook ];

  propagatedBuildInputs = [
    mpi
  ];

  configureFlags = [
    "--enable-parallel"
    "CC=${mpi}/bin/mpicc"
  ];

  patches = [./bin-mv.patch];

}
