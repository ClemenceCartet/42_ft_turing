module Types where

data Config = Config {
  name        :: String,
  alphabet    :: [String]
  -- blank       :: String,
  -- states      :: [String],
  -- initial     :: String,
  -- finals      :: [String],
  -- transitions :: [(String, [(Char, String, Char, Int)])]
} deriving (Show)
