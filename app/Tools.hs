module Tools where

doubleMe :: Integer -> Integer
doubleMe x = x + x

displayableBand :: String -> String -> Char -> String
displayableBand builded band blank = do
    if head band == blank
        then builded ++ [blank, blank]
        else displayableBand (builded ++ [head band]) (tail band) blank

proceed :: String -> Integer -> Char -> String -> [(String, [(Char, String, Char, String)])] -> [String] -> String
proceed band idx blank state transitions finals = do
    if state `elem` finals
        then displayableBand [] band blank
        else "notend"