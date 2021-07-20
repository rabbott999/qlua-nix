{ pkgs, stdenv, fetchgit, openmpi, autoreconfHook, mpi, gfortran }:

stdenv.mkDerivation rec {
  pname = "gsl";
  version = "1.13";
  src = fetchgit {
    url = "https://usqcd.lns.mit.edu/git/LHPC/Public/alien-libs/gsl.git";
    rev = "5c90e2d93009f6f4a9b7843949faf1754033489f";
    sha256 = "19wa6qi183h1vdvh572h51bnfhyq39jsdcl5vmycq41cnpp35nq8";
  };
}
