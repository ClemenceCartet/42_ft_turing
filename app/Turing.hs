module Turing where
import TuringDataTypes

displayableBand :: String -> String
displayableBand band = take 20 band
-- displayableBand band blank = (takeWhile (/= blank) band) ++ [blank, blank]

printError :: Int -> IO ()
printError x
    | x == 1 = putStrLn "State name not found in transitions"
    | x == 11 = putStrLn "State name occurence more than once"
    | x == 2 = putStrLn "Transition not found for this state"
    | x == 21 = putStrLn "More than one transition found for this step"
    | otherwise = putStrLn "Unknown error"

printCurrent :: String -> Int -> String -> Transition -> IO ()
printCurrent band idx state trans = do
    let splitted = splitAt idx band
    putStrLn ("[" ++ fst splitted ++ "<" ++ [head (snd splitted)] ++ ">" ++ (tail (snd splitted)) ++ "]" ++ " (" ++ state ++ ", " ++ [(charRead trans)] ++ ") -> (" ++ (nextState trans) ++ ", " ++ [(replaceChar trans)] ++ ", " ++ (toStringDirection (nextDir trans)) ++ ")")

applyModify :: String -> Int -> Char -> String
applyModify band idx newChar = (take idx band) ++ [newChar] ++ (drop (idx + 1) band)

toStringDirection :: Int -> String
toStringDirection x
    | x == 1 = "RIGHT"
    | otherwise = "LEFT"

proceed :: String -> Int -> Char -> String -> [TransitionMapping] -> [String] -> IO ()
proceed band idx blank state transitions finals = if state `elem` finals
    then putStrLn ("[" ++ displayableBand band ++ "]")
    else do
        let transResult = findTransition transitions state (band !! idx)
        if fst transResult /= 0 then printError $ fst transResult
        else do
            let trans = snd transResult
            printCurrent (displayableBand band) idx state trans
            proceed (applyModify band idx $ replaceChar trans) (idx + (nextDir trans)) blank (nextState trans) transitions finals