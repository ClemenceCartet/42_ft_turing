#!/bin/bash
echo "" > timeCompl.csv
cabal run exes -- machines/palindrome.json 0 >> /dev/null
cabal run exes -- machines/palindrome.json 00 >> /dev/null
cabal run exes -- machines/palindrome.json 000 >> /dev/null
cabal run exes -- machines/palindrome.json 0000 >> /dev/null
cabal run exes -- machines/palindrome.json 00000000 >> /dev/null
cabal run exes -- machines/palindrome.json 0000000000000000 >> /dev/null
cabal run exes -- machines/palindrome.json 00000000000000000000000000000000 >> /dev/null
cabal run exes -- machines/palindrome.json 000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 >> /dev/null