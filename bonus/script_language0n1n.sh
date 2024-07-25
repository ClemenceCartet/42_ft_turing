#!/bin/bash
echo "" > timeCompl.csv
cabal run exes -- machines/language0n1n.json 01 >> /dev/null
cabal run exes -- machines/language0n1n.json 0011 >> /dev/null
cabal run exes -- machines/language0n1n.json 000111 >> /dev/null
cabal run exes -- machines/language0n1n.json 00001111 >> /dev/null
cabal run exes -- machines/language0n1n.json 000000000111111111 >> /dev/null
cabal run exes -- machines/language0n1n.json 000000000000000000111111111111111111 >> /dev/null
cabal run exes -- machines/language0n1n.json 000000000000000000000000000000000000111111111111111111111111111111111111 >> /dev/null
cabal run exes -- machines/language0n1n.json 0000000000000000000000000000000000000000000000000011111111111111111111111111111111111111111111111111 >> /dev/null
