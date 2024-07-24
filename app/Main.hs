module Main where

import System.IO
import System.Environment (getArgs)

import Checking
import Turing
import Types

main :: IO ()
main = do
    args <- getArgs
    checkArgs args
    let jsonFile = head args
        input = args !! 1
    jsonContent <- getJson jsonFile
    case jsonContent of
        Nothing -> putStrLn "Failed to parse json."
        Just content ->
            case checkJson content of
                Nothing -> putStrLn "Your jsonfile is uncorrect."
                Just config ->
                    checkConfig config >> checkInput config input >> do
                    let infiniteIdx = length input
                    let infiniteBand = input ++ [head (blank config), head (blank config)]
                    proceed infiniteBand (initial config) 0 config infiniteIdx
