module Main where
import Turing
import TuringDataTypes
import System.Environment()

main :: IO ()

main = do
    let alphabets = ['1', '.', '+', '-', '=']
    let blank = '.'
    let band = "111-111="
    let infiniteBand = band ++ [blank, blank..]
    let infiniteIdx = length band
    let states = ["scanright", "eraseone", "subone", "skip", "HALT"]
    let initial = "scanright"
    let finals = ["HALT"]
    let transitions = [TransitionMapping "scanright"
                            [Transition '.' "scanright" '.' 1,
                             Transition '1' "scanright" '1' 1,
                             Transition '-' "scanright" '-' 1,
                             Transition '=' "eraseone" '.' (-1)],
                           TransitionMapping "eraseone"
                            [Transition '1' "subone" '=' (-1),
                             Transition '-' "HALT" '.' (-1)],
                           TransitionMapping "subone"
                            [Transition '1' "subone" '1' (-1),
                             Transition '-' "skip" '-' (-1)],
                           TransitionMapping "skip"
                            [Transition '.' "skip" '.' (-1),
                             Transition '1' "scanright" '.' 1]]
    print (take 20 band)
    print alphabets
    print states
    print transitions
    print (head transitions)
    proceed infiniteBand 0 blank initial transitions finals infiniteIdx
    print "end"