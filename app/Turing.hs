module Turing where

displayableBand :: String -> String
displayableBand band = take 20 band
-- displayableBand band blank = (takeWhile (/= blank) band) ++ [blank, blank]

printCurrent :: String -> Int -> String -> Char -> (String, Char, String) -> IO ()
printCurrent band idx state charRead (b, c, d) = do
    let splitted = splitAt idx band
    putStrLn ("[" ++ fst splitted ++ "<" ++ [head (snd splitted)] ++ ">" ++ (tail (snd splitted)) ++ "]" ++ " (" ++ state ++ ", " ++ [charRead] ++ ") -> (" ++ b ++ ", " ++ [c] ++ ", " ++ d ++ ")")


evaluate :: String -> Char -> [(String, [(Char, String, Char, Int)])] -> (Char, String, Char, Int)
evaluate state charRead transitions = do
    let actionsList = head (dropWhile (\(transState, _) -> transState /= state) transitions)
    head (dropWhile (\(a, _, _, _) -> a /= charRead) $ snd actionsList)

applyModify :: String -> Int -> Char -> String
applyModify band idx newChar = (take idx band) ++ [newChar] ++ (drop (idx + 1) band)

toStringDirection :: Int -> String
toStringDirection x
    | x == 1 = "RIGHT"
    | otherwise = "LEFT"

proceed :: String -> Int -> Char -> String -> [(String, [(Char, String, Char, Int)])] -> [String] -> IO ()
proceed band idx blank state transitions finals = if state `elem` finals
    then putStrLn ("[" ++ displayableBand band ++ "]")
    else do
        let (_, b, c, d) = evaluate state (band !! idx) transitions
        printCurrent (displayableBand band) idx state (band !! idx) (b, c, (toStringDirection d))
        proceed (applyModify band idx c) (idx + d) blank b transitions finals