#!/bin/bash
echo "" > timeCompl.csv
cabal run exes -- machines/turing.json "A1.+=SabcTR.c,1;bL.b,=R1a,+R1a,1;a__111+11=" >> /dev/null
cabal run exes -- machines/turing.json "A1.+=SabcTR.c,1;bL.b,=R1a,+R1a,1;a__111+1111111=" >> /dev/null
cabal run exes -- machines/turing.json "A1.+=SabcTR.c,1;bL.b,=R1a,+R1a,1;a__111+1111111111111=" >> /dev/null
cabal run exes -- machines/turing.json "A1.+=SabcTR.c,1;bL.b,=R1a,+R1a,1;a__111111+111111111111111111111=" >> /dev/null
cabal run exes -- machines/turing.json "A1.+=SabcTR.c,1;bL.b,=R1a,+R1a,1;a__111+111111111111111111111111111111111=" >> /dev/null
cabal run exes -- machines/turing.json "A1.+=SabcTR.c,1;bL.b,=R1a,+R1a,1;a__111+1111111111111111111111111111111111111111111=" >> /dev/null
cabal run exes -- machines/turing.json "A1.+=SabcTR.c,1;bL.b,=R1a,+R1a,1;a__111+1111111111111111111111111111111111111111111111111111=" >> /dev/null
cabal run exes -- machines/turing.json "A1.+=SabcTR.c,1;bL.b,=R1a,+R1a,1;a__111+11111111111111111111111111111111111111111111111111111111111111=" >> /dev/null
