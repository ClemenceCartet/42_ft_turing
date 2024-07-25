module Turing where

import Prelude hiding (read, lookup)
import Data.Map (Map, lookup)
import System.Exit (exitSuccess)

import Types

displayableBand :: String -> Char -> Int -> String
displayableBand band blank idx =
    if idx == ((length band) - 1) || (last band) /= blank
    then band ++ [blank, blank]
    else displayableBand (init band) blank idx

displayableResult :: String -> Char -> String
displayableResult band blank =
    if (length band) == 0 || (last band) /= blank
    then band ++ [blank, blank]
    else displayableResult (init band) blank

printError :: String -> Int -> String -> (Int, Transition) -> IO ()
printError band idx state transRes = do
    printCurrent band idx state $ snd transRes
    putStrLn errMsg
    where errMsg
            | errNum == 1 = "State name not found in transitions."
            | errNum == 2 = "Transition not found for this state."
            | errNum == 21 = "More than one transition found for this step."
            | errNum == 3 = "Your program is going to the infinite space."
            | errNum == 4 = "Your program goes before the begin of the band."
            | otherwise = "Unknown error."
            where errNum = fst transRes

printCurrent :: String -> Int -> String -> Transition -> IO ()
printCurrent band idx state trans = do
    let splitted = splitAt idx band
    putStrLn ("[" ++ fst splitted
        ++ "<" ++ [head (snd splitted)] ++ ">"
        ++ (tail (snd splitted)) ++ "]"
        ++ " (" ++ state ++ ", " ++ [head (snd splitted)]
        ++ ") -> (" ++ (to_state trans)
        ++ ", " ++ (write trans)
        ++ ", " ++ (action trans) ++ ")")

applyModify :: String -> Int -> String -> String
applyModify band idx newChar = (take idx band) ++ newChar ++ (drop (idx + 1) band)

toIntDirection :: String -> Int
toIntDirection str
    | str == "RIGHT" = 1
    | str == "LEFT" = (-1)
    | otherwise = 0

findTransition :: Map String [Transition] -> String -> Char -> (Int, Transition)
findTransition transMap state c = do
    case lookup state transMap of
        Just transitions -> do
            -- print transitions
            let transFound = filter (\t -> head (read t) == c) transitions
            case transFound of
                [] -> (2, Transition "Err" "Err" "Err" "Err")
                xs  | length xs > 1 -> (21, Transition "Err" "Err" "Err" "Err")
                    | otherwise -> (0, head transFound)
        Nothing -> (1, Transition "Err" "Err" "Err" "Err")

checkOutOfBand :: Config -> Transition -> String -> String -> Int -> Int -> Int -> IO ()
checkOutOfBand config trans band state idx infiniteIdx nextIdx
    | nextIdx < 0 = printError band idx state (4, trans) >> exitSuccess
    | idx == infiniteIdx
        && (read trans) == (blank config)
        && (to_state trans) == state
        && (action trans) == "RIGHT"
        = printError band idx state (3, trans) >> exitSuccess
    | otherwise = return ()

proceed :: String -> String -> Int -> Config -> Int -> Int -> Int -> IO ()
proceed band state idx config infiniteIdx initSize stepCount = if state `elem` (finals config)
    then do
        putStrLn ("[" ++ displayableResult (take (infiniteIdx + 1) band) (head (blank config)) ++ "]")
        putStrLn ("original input length: " ++ (show initSize) ++ " | Steps: " ++ (show stepCount))
    else do
        let transResult = findTransition (transitions config) state (band !! idx)
        let bandToDisplay = displayableBand (take (infiniteIdx + 1) band) (head (blank config)) idx
        if fst transResult /= 0 then printError bandToDisplay idx state transResult
        else do
            let trans = snd transResult
            let nextIdx = idx + toIntDirection(action trans)
            checkOutOfBand config trans bandToDisplay state idx infiniteIdx nextIdx
            let newBand = applyModify band idx $ write trans
            let newInfIdx = max infiniteIdx nextIdx
            printCurrent bandToDisplay idx state trans
            proceed newBand (to_state trans) nextIdx config newInfIdx initSize (stepCount + 1)