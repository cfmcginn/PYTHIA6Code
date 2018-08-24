Downloaded f.gz from here:
https://www.hepforge.org/downloads/pythia6

gunzip pythia-6.VERSION.f.gz produces .f file
I chose latest version as of 2018.08.24, pythia-6.4.28.f.gz
mv to src

run 'source setPYTHIA6Env.sh' from this top level directory. This will set all pathing for make, bash scripts, etc.

run 'make'
to clean run 'make clean'

To get an x-section do:

./bin/xsection63.exe <pthatVal>

I havent put protections for no argument so make sure you give it a pthatval

to get a suite of cross sections try

bash bashDir/getXSections.sh

Note this is setup for at least 10 cores, so modify accordingly