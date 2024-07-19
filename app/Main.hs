{-# LANGUAGE OverloadedStrings #-}
module Main where

import System.Environment (getArgs, getProgName)
import System.IO
import System.Exit (exitSuccess)
import Data.Aeson
import qualified Data.ByteString.Lazy as BL

import Types

instance FromJSON Config where
    parseJSON = withObject "Config" $ \v -> Config
        <$> v .: "name"
        <*> v .: "alphabet"

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

-- createConfig :: String -> Config
-- createConfig blop = Config blop ["hello"]

main :: IO ()
main = do
    args <- getArgs
    checkArgs args
    let jsonFile = head args
        input = args !! 1
    jsonContent <- getJson jsonFile
    case jsonContent of
        Nothing -> putStrLn "Your JSON file is not valid."
        Just json -> putStrLn show json -- pourquoi json ?!!, et pas Config ?

    -- let test = createConfig "Hello"
    -- print test

