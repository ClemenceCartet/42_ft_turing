import System.Environment
import System.IO

main :: IO ()


main = do
    args <- getArgs
    mapM putStrLn args -- maps the function over the list and then sequences it
    if length args == 1
        then do
            handle <- openFile (head args) ReadMode
            contents <- hGetContents handle
            putStrLn contents
            hClose handle
        else putStrLn "You must pass your config file to this program."
