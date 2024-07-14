module Main where
import Tools
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
                                     ('.', "scanright", '.', "RIGHT"),
                                     ('1', "scanright", '1', "RIGHT"),
                                     ('-', "scanright", '-', "RIGHT"),
                                     ('=', "eraseone", '.', "LEFT")]),
                       ("eraseone",[
                                    ('1', "subone", '=', "LEFT"),
                                    ('-', "HALT", '.', "LEFT")]),
                       ("subone",[
                                  ('1', "subone", '1', "LEFT"),
                                  ('-', "skip", '-', "LEFT")]),
                       ("skip",[
                                ('.', "skip", '.', "LEFT"),
                                ('1', "scanright", '.', "RIGHT")])
                      ]
    print (take 20 band)
    print alphabets
    print states
    print transitions
    print (head transitions)
    print (proceed band 0 '.' "HALT" transitions finals)
    args <- getArgs
    print([mySwitch(read(a)) | a <- args])
    print "end"