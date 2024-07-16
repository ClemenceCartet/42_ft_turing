module Turing where

displayableBand :: String -> Char -> String
displayableBand band blank = take 20 band
-- displayableBand band blank = (takeWhile (/= blank) band) ++ [blank, blank]

printCurrent :: String -> Int -> String -> Char -> (String, Char, String) -> IO ()
printCurrent band idx state read (b, c, d) = do
    let splitted = splitAt idx band
    putStrLn ("[" ++ fst splitted ++ "<" ++ [head (snd splitted)] ++ ">" ++ (tail (snd splitted)) ++ "]" ++ " (" ++ state ++ ", " ++ [read] ++ ") -> (" ++ b ++ ", " ++ [c] ++ ", " ++ d ++ ")")


evaluate :: String -> Char -> [(String, [(Char, String, Char, Int)])] -> (Char, String, Char, Int)
evaluate state read transitions = do
    let actionsList = head (dropWhile (\(transState, actions) -> transState /= state) transitions)
    head (dropWhile (\(a, b, c, d) -> a /= read) $ snd actionsList)

applyModify :: String -> Int -> Char -> String
applyModify band idx newChar = (take idx band) ++ [newChar] ++ (drop (idx + 1) band)

toStringDirection :: Int -> String
toStringDirection 1 = "RIGHT"
toStringDirection (-1) = "LEFT"
toStringDirection x = "Error"

proceed :: String -> Int -> Char -> String -> [(String, [(Char, String, Char, Int)])] -> [String] -> IO ()
proceed band idx blank state transitions finals = if state `elem` finals
    then putStrLn ("[" ++ displayableBand band blank ++ "]")
    else do
        let (a, b, c, d) = evaluate state (band !! idx) transitions
        printCurrent (displayableBand band blank) idx state (band !! idx) (b, c, (toStringDirection d))
        proceed (applyModify band idx c) (idx + d) blank b transitions finals