module Main where
import Turing
import System.Environment

mySwitch :: Integer -> String

mySwitch < 1 = "too small"
mySwitch 1 = "too ez"
mySwitch 2 = "between 3 and 5"
mySwitch a = show(toInteger(doubleMe a))

main :: IO ()

main = do
    let alphabets = ['1', '.', '-', '=']
    let blank = '.'
    let band = "111-11" ++ [blank,blank..]
    let states = ["scanright", "eraseone", "subone", "skip", "HALT"]
    let initial = "scanright"
    let finals = ["HALT"]
    let transitions = [
                       ("scanright",[
                                     ('.', "scanright", '.', 1),
                                     ('1', "scanright", '1', (-1)),
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
    proceed band 0 '.' initial transitions finals
    args <- getArgs
    print([mySwitch(read(a)) | a <- args])
    print "end"