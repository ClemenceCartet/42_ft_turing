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
getStateName (TransitionMapping x _) -> x

getTransitions :: TransitionMapping -> [Transition]
getTransitions (TransitionMapping _ x) -> x

findTransition :: [TransitionMapping] -> String -> Char -> (Bool, Transition)
findTransition state trans c = do
    let 