module Main where

import System.Environment (getArgs, getProgName)
import System.IO
import System.Exit (exitSuccess)
import Data.Aeson
import qualified Data.ByteString.Lazy as BL

import Types

checkJson :: Value -> Maybe Config
checkJson content = do
    where expected = ["name", "alphabet", "blank", "states", ""]

getJson :: String -> IO (Maybe Value)
getJson fileName = do
    json <- BL.readFile fileName
    return (decode content)
-- the Value type, which is an instance of FromJSON, is used to represent an arbitrary JSON AST (abstract syntax tree)

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
    print
    args <- getArgs
    checkArgs args
    let jsonFile = head args
        input = args !! 1
    jsonContent <- getJson jsonFile
    case jsonContent of
        Nothing -> putStrLn "Failed to parse json."
        Just content -> -- pourquoi json ?!!, et pas Config ?
            case checkJson content of
                Nothing -> putStrLn "Your jsonfile is incorrect."
                Just config -> execute config

