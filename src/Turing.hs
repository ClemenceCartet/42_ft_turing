module Turing where

import Prelude hiding (read, lookup)
import Data.Map (Map, lookup)

import Types

displayableBand :: String -> Char -> Int -> String
displayableBand band blank idx = if idx == ((length band) - 1) || (last band) /= blank
    then band ++ [blank, blank]
    else displayableBand (init band) blank idx

displayableResult :: String -> Char -> String
displayableResult band blank = if (length band) == 0 || (last band) /= blank then band ++ [blank, blank]
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
            | otherwise = "Unknown error."
            where errNum = fst transRes

printCurrent :: String -> Int -> String -> Transition -> IO ()
printCurrent band idx state trans = do
    let splitted = splitAt idx band
    putStrLn ("[" ++ fst splitted ++ "<" ++ [head (snd splitted)] ++ ">" ++ (tail (snd splitted)) ++ "]" ++ " (" ++ state ++ ", " ++ [head (snd splitted)] ++ ") -> (" ++ (to_state trans) ++ ", " ++ (write trans) ++ ", " ++ (action trans) ++ ")")

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

proceed :: String -> String -> Int -> Config -> Int -> IO ()
proceed band state idx config infiniteIdx = if state `elem` (finals config)
    then putStrLn ("[" ++ displayableResult (take (infiniteIdx + 1) band) (head (blank config)) ++ "]")
    else do
        let transResult = findTransition (transitions config) state (band !! idx)
        if fst transResult /= 0 then printError (displayableBand (take (infiniteIdx + 1) band) (head (blank config)) idx) idx state transResult
        else do
            let trans = snd transResult
            if idx == infiniteIdx && (read trans) == (blank config) && (to_state trans) == state && (action trans) == "RIGHT"
            then printError (displayableBand (take (infiniteIdx + 1) band) (head (blank config)) idx) idx state (3, trans)
            else do
                printCurrent (displayableBand (take (infiniteIdx + 1) band) (head (blank config)) idx) idx state trans
                proceed (applyModify band idx (write trans)) (to_state trans) (idx + (toIntDirection(action trans))) config (max infiniteIdx (idx + (toIntDirection(action trans))))