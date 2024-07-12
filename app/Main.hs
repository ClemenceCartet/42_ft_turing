module Main where
import Baby
import System.Environment

mySwitch :: Integer -> String

mySwitch < 1 = "too small"
mySwitch 1 = "too ez"
mySwitch 2 = "between 3 and 5"
mySwitch a = show(toInteger(doubleMe a))

main :: IO ()

main = do
    args <- getArgs
    print([mySwitch(read(a)) | a <- args])