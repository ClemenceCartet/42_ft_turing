#!/bin/bash
echo -n "" > timeCompl.csv
cabal run exes -- machines/unary_add.json 1+1= >> /dev/null
cabal run exes -- machines/unary_add.json 11+11= >> /dev/null
cabal run exes -- machines/unary_add.json 1111+1111= >> /dev/null
cabal run exes -- machines/unary_add.json 11111111+11111111= >> /dev/null
cabal run exes -- machines/unary_add.json 1111111111111111+11111111111111111= >> /dev/null
cabal run exes -- machines/unary_add.json 11111111111111111111111111111111+111111111111111111111111111111111= >> /dev/null
cabal run exes -- machines/unary_add.json 111111111111111111111111111111111111111111+1111111111111111111111111111111111111= >> /dev/null