#!/bin/bash
echo "" > timeCompl.csv
cabal run exes -- machines/language02n.json 0 >> /dev/null
cabal run exes -- machines/language02n.json 00 >> /dev/null
cabal run exes -- machines/language02n.json 000 >> /dev/null
cabal run exes -- machines/language02n.json 0000 >> /dev/null
cabal run exes -- machines/language02n.json 000000000>> /dev/null
cabal run exes -- machines/language02n.json 0000000000000000>> /dev/null
cabal run exes -- machines/language02n.json 000000000000000000000000000000000>> /dev/null
cabal run exes -- machines/language02n.json 0000000000000000000000000000000000000000000000000000000000000000>> /dev/null
cabal run exes -- machines/language02n.json 0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000>> /dev/null