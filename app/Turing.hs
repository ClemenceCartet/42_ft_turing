module Turing where
import TuringDataTypes

displayableBand :: String -> String
displayableBand band = take 20 band
-- displayableBand band blank = (takeWhile (/= blank) band) ++ [blank, blank]

printError :: String -> Int -> String -> (Int, Transition) -> IO ()
printError band idx state transRes = do
    let errNum = fst transRes
    printCurrent band idx state $ snd transRes
    if errNum == 1 then putStrLn "State name not found in transitions"
    else if errNum == 11 then putStrLn "State name occurence more than once"
    else if errNum == 2 then putStrLn "Transition not found for this state"
    else if errNum == 21 then putStrLn "More than one transition found for this step"
    else putStrLn "Unknown error"

printCurrent :: String -> Int -> String -> Transition -> IO ()
printCurrent band idx state trans = do
    let splitted = splitAt idx band
    putStrLn ("[" ++ fst splitted ++ "<" ++ [head (snd splitted)] ++ ">" ++ (tail (snd splitted)) ++ "]" ++ " (" ++ state ++ ", " ++ [head (snd splitted)] ++ ") -> (" ++ (nextState trans) ++ ", " ++ [(replaceChar trans)] ++ ", " ++ (toStringDirection (nextDir trans)) ++ ")")

applyModify :: String -> Int -> Char -> String
applyModify band idx newChar = (take idx band) ++ [newChar] ++ (drop (idx + 1) band)

toStringDirection :: Int -> String
toStringDirection x
    | x == 1 = "RIGHT"
    | x == (-1) = "LEFT"
    | otherwise = "Error"

proceed :: String -> Int -> Char -> String -> [TransitionMapping] -> [String] -> IO ()
proceed band idx blank state transitions finals = if state `elem` finals
    then putStrLn ("[" ++ displayableBand band ++ "]")
    else do
        let transResult = findTransition transitions state (band !! idx)
        if fst transResult /= 0 then printError (displayableBand band) idx state transResult
        else do
            let trans = snd transResult
            printCurrent (displayableBand band) idx state trans
            proceed (applyModify band idx $ replaceChar trans) (idx + (nextDir trans)) blank (nextState trans) transitions finals