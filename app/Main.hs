module Main where

import System.Environment (getArgs, getProgName)
import System.IO
import System.Exit (exitSuccess)
import Data.Aeson
import qualified Data.ByteString.Lazy as BL

import Types

getJson :: String -> IO (Maybe Config)
getJson fileName = do
    json <- BL.readFile fileName
    return (decode json)

printHelp :: IO ()
printHelp = do
    program <- getProgName
    putStrLn $ "usage: " ++ program ++ " [-h] jsonfile input\n\
    \\n\
    \positional arguments:\n\
    \ jsonfile              json description of the machine\n\
    \\n\
    \ input                 input of the machine\n\
    \\n\
    \optional arguments:\n\
    \ -h, --help            show this help message and exit"

checkArgs :: [String] -> IO ()
checkArgs args
    | len == 0 = putStrLn "Empty input..." >> exitSuccess
    | head args == "-h" || head args == "--help" = printHelp >> exitSuccess
    | len == 2 = return ()
    | otherwise = putStrLn "Incorrect number of arguments..." >> exitSuccess
    where len = length args

main :: IO ()
main = do
    args <- getArgs
    checkArgs args
    let jsonFile = head args
        input = args !! 1
    jsonContent <- getJson jsonFile
    case jsonContent of
        Nothing -> putStrLn "Your JSON file is not valid."
        Just json -> print json -- pourquoi json ?!!, et pas Config ?
