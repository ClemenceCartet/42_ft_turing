module DisplayConfig where

import Types
import Prelude hiding (read)
import Data.Map (Map, keys, elems, (!))

makeBorderUp :: Int -> String
makeBorderUp len = "/" ++ (take (2 * len) ['-', '-'..]) ++ "\\"

makeBorderDown :: Int -> String
makeBorderDown len = "\\" ++ (take (2 * len) ['-', '-'..]) ++ "/"

makeEmptyBorder :: Int -> String
makeEmptyBorder len = "|" ++ (take (2 * len) [' ', ' '..]) ++ "|"

displayName :: String -> Int -> IO ()
displayName name len = do
    let nameLen = length name
    let modulo = mod nameLen 2
    let toRemove = div nameLen 2
    let spaces = [' ', ' '..]
    putStrLn ("|" ++ (take (len - toRemove) spaces)
        ++ name ++ (take (len - toRemove - modulo) spaces) ++ "|")

displayHeader :: String -> Int -> IO ()
displayHeader name len = do
    let emptyBorder = makeEmptyBorder len
    putStrLn $ makeBorderUp len
    putStrLn emptyBorder
    displayName name len
    putStrLn emptyBorder
    putStrLn $ makeBorderDown len

displayFooter :: Int -> IO ()
displayFooter len = do
    putStrLn "\n"
    putStrLn (makeBorderUp len)
    displayName "Let's go!!" len
    putStrLn (makeBorderDown len)
    putStrLn "\n"

recuDisplay :: [String] -> IO ()
recuDisplay strs = do
    if length strs == 1
        then putStrLn (head strs ++ "]")
    else do
        putStr (head strs ++ ", ")
        recuDisplay $ tail strs

displayAlphabet :: [String] -> IO ()
displayAlphabet alp = do
    putStr "Alphabet : ["
    recuDisplay alp

displayStates :: [String] -> IO ()
displayStates states = do
    putStr "States : ["
    recuDisplay states

displayInitial :: String -> IO ()
displayInitial init = putStrLn ("Initial: " ++ init)

displayBlank :: String -> IO ()
displayBlank blank = putStrLn ("Blank: " ++ blank)

displayFinals :: [String] -> IO ()
displayFinals finals = do
    putStr "Finals: ["
    recuDisplay finals

displayKeyTransitions :: String -> [Transition] -> IO ()
displayKeyTransitions key transList =
    if length transList > 0 then do
        let trans = head transList
        putStrLn ("(" ++ key ++ ", " ++ (read trans) ++ ") -> ("
                    ++ (to_state trans) ++ ", " ++ (write trans)
                    ++ ", " ++ (action trans) ++ ")")
        displayKeyTransitions key $ tail transList
    else return ()

recuDisplayTransitions :: [String] -> Map String [Transition] -> IO ()
recuDisplayTransitions keyList trans = do
    if length keyList > 0 then do
        displayKeyTransitions (head keyList) (trans ! (head keyList))
        recuDisplayTransitions (tail keyList) trans
    else return ()

displayTransitions :: Map String [Transition] -> IO ()
displayTransitions trans = do
    putStrLn "\n         Transitions:"
    recuDisplayTransitions (keys trans) trans

_displayConfig :: Config -> Int -> IO ()
_displayConfig config len = do
    displayHeader (name config) len
    displayAlphabet (alphabet config)
    displayStates (states config)
    displayInitial (initial config)
    displayBlank (blank config)
    displayFinals (finals config)
    displayTransitions (transitions config)
    displayFooter len

displayConfig :: Config -> Int -> IO ()
displayConfig config len
    | length (name config) >= len = _displayConfig config (length (name config) + 2) 
    | otherwise = _displayConfig config len
