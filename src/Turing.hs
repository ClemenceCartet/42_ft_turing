module Turing where
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
    let errNum = fst transRes
    printCurrent band idx state $ snd transRes
    if errNum == 1 then putStrLn "State name not found in transitions"
    else if errNum == 11 then putStrLn "State name occurence more than once"
    else if errNum == 2 then putStrLn "Transition not found for this state"
    else if errNum == 21 then putStrLn "More than one transition found for this step"
    else if errNum == 3 then putStrLn "Your program is going to the infinite space"
    else putStrLn "Unknown error"

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