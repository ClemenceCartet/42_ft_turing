module Main where
import Turing
import TuringDataTypes
import System.Environment()

main :: IO ()

main = do
    let alphabets = ['1', '.', '+', '-', '=']
    let blank = '.'
    let band = "111-1+1=" ++ [blank,blank..]
    let states = ["scanright", "eraseone", "subone", "skip", "HALT"]
    let initial = "scanright"
    let finals = ["HALT"]
    let transitionTyped = [TransitionMapping "scanright"
                            [Transition '.' "scanright" '.' 1,
                             Transition '1' "scanright" '1' 1,
                             Transition '-' "scanright" '-' 1,
                             Transition '=' "eraseone" '.' (-1)],
                           TransitionMapping "erasone"
                            [Transition '1' "subone" '=' (-1),
                             Transition '-' "HALT" '.' (-1)],
                           TransitionMapping "subone"
                            [Transition '1' "subone" '1' (-1),
                             Transition '-' "skip" '-' (-1)],
                           TransitionMapping "skip"
                            [Transition '.' "skip" '.' (-1),
                             Transition '1' "scanright" '.' 1]]
    let transitions = [
                       ("scanright",[
                                     ('.', "scanright", '.', 1),
                                     ('1', "scanright", '1', 1),
                                     ('-', "scanright", '-', 1),
                                     ('=', "eraseone", '.', (-1))]),
                       ("eraseone",[
                                    ('1', "subone", '=', (-1)),
                                    ('-', "HALT", '.', (-1))]),
                       ("subone",[
                                  ('1', "subone", '1', (-1)),
                                  ('-', "skip", '-', (-1))]),
                       ("skip",[
                                ('.', "skip", '.', (-1)),
                                ('1', "scanright", '.', 1)])
                      ]
    print (take 20 band)
    print alphabets
    print states
    print transitions
    print (head transitions)
    proceed band 0 blank initial transitions finals
    print "end"