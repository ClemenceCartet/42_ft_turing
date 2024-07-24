<<<<<<< HEAD
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use when" #-}
{-# HLINT ignore "Use any" #-}
{-# HLINT ignore "Use all" #-}
module Main where

import Prelude hiding (read)
import System.Environment (getArgs, getProgName)
import System.IO
import System.Exit (exitSuccess)
import Data.Aeson
import qualified Data.Aeson.KeyMap as KM
import Data.Aeson.Key (toString)
import qualified Data.ByteString.Lazy as BL
import Data.Map (keys, elems)

import Types

checkConfig :: Config -> IO ()
checkConfig config = do
    let errorMsg
            | null (alphabet config) = "Alphabet is empty."
            | any (\c -> length c /= 1) (alphabet config) = "Alphabet should be one char."
            | length (blank config) /= 1 = "Blank should be one char."
            | head (blank config) `notElem` concat (alphabet config) = "Blank should be in alphabet."
            | null (states config) = "States is empty."
            | any (\s -> length s <= 1) (states config) = "A state should be at least 2 chars."
            | initial config `notElem` states config = "Initial state should be in states."
            | null (finals config) = "Finals are empty."
            | any (`notElem` states config) (finals config) = "Final states should be in states."
            | null (transitions config) = "Transitions are empty."
            | any (`notElem` states config) (keys (transitions config)) = "Transition states should be in states."
            | initial config `notElem` keys (transitions config) = "There must be an initial state in transitions."
            | any (\trans -> length (read trans) /= 1) (concat (elems (transitions config))) = "Read should be in one char."
            | any (\trans -> head (read trans) `notElem` concat (alphabet config)) (concat (elems (transitions config))) = "Read char should be in alphabet."
            | any (\trans -> to_state trans `notElem` states config) (concat (elems (transitions config))) = "To state should be in states."
            | all (\trans -> to_state trans `notElem` finals config) (concat (elems (transitions config))) = "There must be a final state in at least one to state transitions."
            | any (\trans -> length (write trans) /= 1) (concat (elems (transitions config))) = "Write should be in one char."
            | any (\trans -> head (write trans) `notElem` concat (alphabet config)) (concat (elems (transitions config))) = "Write char should be in alphabet."
            | any (\trans -> action trans /= "RIGHT" && action trans /= "LEFT") (concat (elems (transitions config))) = "Action should be RIGHT or LEFT."
            | otherwise = ""
    if null errorMsg then
        return ()
        else putStrLn errorMsg >> exitSuccess
     
checkInput :: Config -> String -> IO ()
checkInput config input
    | null input = putStrLn "Input is empty."
    | head (blank config) `elem` input = putStrLn "Input shouldn't contain blank char."
    | not (all (`elem` concat (alphabet config)) input) = putStrLn "Input characters must be in alphabet."
    | otherwise = print config

checkJson :: Value -> Maybe Config
checkJson json@(Object content) = do
    let extraKeys = filter (`notElem` expectedKeys) (map toString (KM.keys content))
    -- print extraKeys
    if null extraKeys
        then case fromJSON json of
            Success config -> Just config
            Error _        -> Nothing
        else Nothing
    where expectedKeys = ["name", "alphabet", "blank", "states", "initial", "finals", "transitions"]
-- fromJSON retrun a Result a, Result can be Success or Error String

getJson :: String -> IO (Maybe Value)
getJson fileName = do
    content <- BL.readFile fileName
    return (decode content)
-- the Value type, which is an instance of FromJSON, is used to represent
-- an arbitrary JSON AST (abstract syntax tree)

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
    | otherwise = putStrLn "Uncorrect number of arguments..." >> exitSuccess
    where len = length args
-- >> sequence two monadic actions
-- >>= pass the result of the first monadic action to the secund

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
                    checkConfig config >> checkInput config input
                    -- execution
=======
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
>>>>>>> haskell
