module Turing where

displayableBand :: String -> Char -> String
displayableBand band blank = (takeWhile (/= blank) band) ++ [blank, blank]

printCurrent :: String -> Int -> IO ()
printCurrent s i = do
    let splitted = splitAt i s
    putStrLn (fst splitted ++ "<" ++ [head (snd splitted)] ++ ">" ++ (tail (snd splitted)))

evaluate :: String -> Char -> [(String, [(Char, String, Char, Int)])] -> (Char, String, Char, Int)
evaluate state read transitions = do
    let actionsList = head (dropWhile (\(transState, actions) -> transState /= state) transitions)
    head (dropWhile (\(a, b, c, d) -> a /= read) $ snd actionsList)

proceed :: String -> Int -> Char -> String -> [(String, [(Char, String, Char, Int)])] -> [String] -> IO ()
proceed band idx blank state transitions finals = if state `elem` finals
    then print (displayableBand band blank)
    else do
        printCurrent (displayableBand band blank) idx