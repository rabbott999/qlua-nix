{ pkgs, stdenv, fetchgit, openmpi, autoreconfHook, mpi, gfortran }:

stdenv.mkDerivation rec {
  pname = "arpack";
  version = "0.1.0";
  src = fetchgit {
    url = "https://usqcd.lns.mit.edu/git/LHPC/Public/alien-libs/arpack.git";
    rev = "33da7f4e3bc07fc010f8bfbe786bb4df17eea7a4";
    sha256 = "18h8xm0h022df76lln6fkvsawg7y97ny4zrkismbybn8lya0a6vh";
  };

  propagatedBuildInputs = [
    mpi
  ];

  buildInputs = [
    gfortran
  ];

  configurePhase = ''
    echo "FC      = ${mpi.out}/bin/mpif77" >  ARmake.config
    echo "FFLAGS  = "                      >> ARmake.config
    echo "PFC     = ${mpi.out}/bin/mpif77" >> ARmake.config
    echo "PFFLAGS = "                      >> ARmake.config
    echo "MPILIBS = "                      >> ARmake.config
    echo "SKIP_BLAS   = "                  >> ARmake.config
    echo "SKIP_LAPACK = "                  >> ARmake.config
    export home=$PWD
    export prefix=$out
  '';

  buildPhase = ''
    make all
  '';

  dontInstall = true;

  patches = [./tmp.patch];
}
