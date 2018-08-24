C-----------------------------------------------------------------
C...  Preamble: declarations.
C...  All real arithmetic in double precision.
      IMPLICIT DOUBLE PRECISION(A-H, O-Z)
C...  Three Pythia functions return integers, so need declaring.
      CHARACTER(len=32) :: ARG
      INTEGER ARGINT
      INTEGER PYK,PYCHGE,PYCOMP
      INTEGER*4 n, time
C...  EXTERNAL statement links PYDATA on most machines.
      EXTERNAL PYDATA
C...  Commonblocks.
C...  The event record.
      COMMON/PYJETS/N,NPAD,K(4000,5),P(4000,5),V(4000,5)
C...  Parameters.
      COMMON/PYDAT1/MSTU(200),PARU(200),MSTJ(200),PARJ(200)
C...  Particle properties + some flavour parameters.
      COMMON/PYDAT2/KCHG(500,4),PMAS(500,4),PARF(2000),VCKM(4,4)
C...  Decay information.
      COMMON/PYDAT3/MDCY(500,3),MDME(8000,2),BRAT(8000),KFDP(8000,5)
C...  Selection of hard scattering subprocesses.
      COMMON/PYSUBS/MSEL,MSELPD,MSUB(500),KFIN(2,-40:40),CKIN(200)
C...  Parameters.
      COMMON/PYPARS/MSTP(200),PARP(200),MSTI(200),PARI(200)
C...  Supersymmetry parameters.
      COMMON/PYMSSM/IMSS(0:99),RMSS(0:99)
      COMMON/PYDATR/MRPY(6),RRPY(100)
C-----------------------------------------------------------------

C...Main parameters of run: c.m. energy and number of events.
      CALL get_command_argument(1, ARG)
      read(ARG, '(I32)') ARGINT
      ECM=5020.0D0
      NEV=100000
      CKIN(3)=ARGINT
      CKIN(4)=-1D0
      MSTP(81)=0
C...Select all hard processes (non-diffractive).
      MSEL=1
C...  Initialize.
      CALL PYINIT('CMS','p+','p+',ECM)
C-----------------------------------------------------------------
C...Second section: event loop.
      n = time()
      MRPY(1)=n
C...Outer loop over ME and PS options.
      DO 300 ICA=1
         MSTP(81)=0
C...Begin event loop.
        DO 200 IEV=1,NEV
           CALL PYEVNT
C...End event loop.
  200   CONTINUE

C...End outer loop.
  300   CONTINUE

C...Third section: produce output and end.
C...  Cross section table.
      CALL PYSTAT(1)
      END


