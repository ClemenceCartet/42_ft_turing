import System.Environment (getArgs, getProgName)
import System.IO
import System.Exit (exitSuccess)


parseFile :: [String] -> IO ()
parseFile config = do
    if head (head config) == '{'
        then print "ok"
        else print "no"

readFromFile :: String -> IO String
readFromFile filePath = do
    handle <- openFile filePath ReadMode
    hGetContents handle
    -- hClose handle 
    -- return contents

printHelp :: IO ()
printHelp = do
    program <- getProgName
    putStrLn $ "usage: " ++ program ++ " [-h] jsonfile input\n\
    \\n\
    \positional arguments:\n\
    \ jsonfile              json description of the machine\n\
    \\n\
    \ input                 input of the machine\n\
    \\n\
    \optional arguments:\n\
    \ -h, --help            show this help message and exit"

checkArgs :: [String] -> IO ()
checkArgs args
    | len == 0 = putStrLn "Empty input..." >> exitSuccess
    | head args == "-h" || head args == "--help" = printHelp >> exitSuccess
    | len == 2 = return ()
    | otherwise = putStrLn "Incorrect number of arguments..." >> exitSuccess
    where len = length args

main :: IO ()
main = do
    args <- getArgs
    checkArgs args
    let (jsonfile, input) = (args !! 0, args !! 1)

    --         contents <- readFromFile (head args)
    --         -- putStrLn contents
    --         let config = lines contents
    --         parseFile config
    --         -- print(length config)
    --     else putStrLn "You must pass your config file to this program."
