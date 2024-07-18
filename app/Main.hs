import System.Environment
import System.IO


parseFile :: [String] => IO ()
parseFile config = do
    if head (head config) == '{'
        then print("ok")
        else print("no")

readFromFile :: String -> IO String
readFromFile filePath = do
    handle <- openFile filePath ReadMode
    hGetContents handle
    -- hClose handle

main :: IO ()
main = do
    args <- getArgs
    mapM putStrLn args -- maps the function over the list and then sequences it
    if length args == 1
        then do
            contents <- readFromFile (head args)
            -- putStrLn contents
            let config = lines contents
            parseFile config
            -- print(length config)
        else putStrLn "You must pass your config file to this program."
