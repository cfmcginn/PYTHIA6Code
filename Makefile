MKDIR_BIN = mkdir -p $(PYTHIA6PATH)bin
MKDIR_LIB = mkdir -p $(PYTHIA6PATH)lib

ifndef PYTHIA6PATH
$(error PYTHIA6PATH is not set at all. Do 'source setPYTHIA6Env.sh')
endif

CHECK_PYTHIA6PATH=printf "\nPYTHIA6PATH is set to: \'$(PYTHIA6PATH)\'\n   !!!IF PYTHIA6PATH IS EMPTY THE BUILD WILL FAIL!!!\n   Run 'source \setPYTHIA6Env.sh' in top level PYTHIA6 directory to fix.\n\n"

ROOT = `root-config --cflags --glibs`
CXX = g++
CXXFLAGS = -Wall -O2 -Wextra -Wno-unused-local-typedefs  -Werror -Wno-deprecated-declara\
tions -std=c++11
ifeq "$(GCCVERSION)" "1"
  CXXFLAGS += -Wno-error=misleading-indentation
endif

#fortran var
FC := gfortran
FFLAGS := -g -static

all: checkPyt6 mkdirBin mkdirLib lib/pythia-6.4.28.o lib/xsection63.o bin/xsection63.exe

mkdirBin:
	$(MKDIR_BIN)

mkdirLib:
	$(MKDIR_LIB)

checkPyt6:
	@$(CHECK_PYTHIA6PATH)


lib/pythia-6.4.28.o:
	$(FC) -c -o $(PYTHIA6PATH)/lib/pythia-6.4.28.o $(PYTHIA6PATH)/src/pythia-6.4.28.f

lib/xsection63.o: $(PYTHIA6PATH)lib/pythia-6.4.28.o
	$(FC) -c -o $(PYTHIA6PATH)/lib/xsection63.o $(PYTHIA6PATH)/src/xsection63.f

bin/xsection63.exe: $(PYTHIA6PATH)/lib/pythia-6.4.28.o $(PYTHIA6PATH)/lib/xsection63.o
	$(FC) -o $@ $^ 

clean:
	rm -f $(PYTHIA6PATH)*~
	rm -f $(PYTHIA6PATH)\#*.*#
	rm -f $(PYTHIA6PATH)bashDir/*~
	rm -f $(PYTHIA6PATH)bashDir/\#*.*#
	rm -f $(PYTHIA6PATH)bin/*.exe
	rm -f $(PYTHIA6PATH)include/#*.*#
	rm -f $(PYTHIA6PATH)include/*~
	rm -f $(PYTHIA6PATH)lib/py*.o 
	rm -f $(PYTHIA6PATH)lib/main*.o 
	rm -f $(PYTHIA6PATH)lib/xse*.o 
	rm -f $(PYTHIA6PATH)src/#*.*#
	rm -f $(PYTHIA6PATH)src/*~

	rmdir $(PYTHIA6PATH)bin
	rmdir $(PYTHIA6PATH)lib
.PHONY: all
