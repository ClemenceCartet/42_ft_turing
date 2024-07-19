module TuringDataTypes where

data Transition = Transition Char String Char Int deriving (Show)

data TransitionMapping = TransitionMapping String [Transition] deriving (Show)

charRead :: Transition -> Char
charRead (Transition x _ _ _) = x

nextState :: Transition -> String
nextState (Transition _ x _ _) = x

replaceChar :: Transition -> Char
replaceChar (Transition _ _ x _) = x

nextDir :: Transition -> Int
nextDir (Transition _ _ _ x) = x

getStateName :: TransitionMapping -> String
getStateName (TransitionMapping x _) = x

getTransitions :: TransitionMapping -> [Transition]
getTransitions (TransitionMapping _ x) = x

-- 0 = OK
-- 1 = stateName not found
-- 11 = more then one stateName occurence found
-- 2 = transition not found
-- 21 = more than one transition occurence found
-- if not 0, the value of Transition doesn't matter
findTransition :: [TransitionMapping] -> String -> Char -> (Int, Transition)
findTransition allTrans state c = do
    let trMapFound = filter (\trMap -> (getStateName trMap) == state) allTrans
    if length trMapFound == 0 then (1, Transition 'E' "Err" 'E' 0)
    else if length trMapFound > 1 then (11, Transition 'E' "Err" 'E' 0)
    else do
        let transFound = filter (\trans -> (charRead trans) == c) $ getTransitions $ head trMapFound
        if length transFound == 0 then (2, Transition 'E' "Err" 'E' 0)
        else if length transFound > 1 then (21, Transition 'E' "Err" 'E' 0)
        else (0, head transFound)
