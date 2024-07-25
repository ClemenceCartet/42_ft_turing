module Main where

import System.IO
import System.Environment (getArgs)
import Control.Exception
import Data.Aeson

import Checking
import Turing
import Types
import DisplayConfig

run :: Maybe Value -> String -> IO ()
run Nothing _ = putStrLn "Failed to parse json."
run (Just content) input =
    case checkJson content of
        Nothing -> putStrLn "Your jsonfile is uncorrect."
        Just config ->
            checkConfig config >> checkInput config input >> do
            let infiniteIdx = length input
            let infiniteBand = input ++ [head (blank config), head (blank config)..]
            displayConfig config 40
            proceed infiniteBand (initial config) 0 config infiniteIdx infiniteIdx 0
            let blop = show 5 ++ "," ++ show 10 ++ "\n"
            result <- try (appendFile "timeCompl.csv" blop) :: IO (Either SomeException ())
            case result of
                Left err -> putStrLn (show err)
                Right _ -> return ()

main :: IO ()
main = do
    args <- getArgs
    checkArgs args
    let jsonFile = head args
        input = args !! 1
    jsonContent <- getJson jsonFile
    case jsonContent of
        Left err -> putStrLn err
        Right maybeContent -> run maybeContent input
