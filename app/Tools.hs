module Tools where

doubleMe :: Integer -> Integer
doubleMe x = x + x

displayableBand :: String -> String -> Char -> String
displayableBand builded band blank = if head band == blank
    then builded ++ [blank, blank]
    else displayableBand (builded ++ [head band]) (tail band) blank

printCurrent :: String -> Int -> IO ()
printCurrent s i = do
    let splitted = splitAt i s
    putStrLn (fst splitted ++ "<" ++ [head (snd splitted)] ++ ">" ++ (tail (snd splitted)))

proceed :: String -> Int -> Char -> String -> [(String, [(Char, String, Char, String)])] -> [String] -> IO ()
proceed band idx blank state transitions finals = if state `elem` finals
    then print (displayableBand [] band blank)
    else do
        printCurrent (displayableBand [] band blank) idx