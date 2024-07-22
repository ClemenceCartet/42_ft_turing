{-# LANGUAGE DeriveGeneric #-}
module Types where

import GHC.Generics

data Transition = Transition {
  read     :: String,
  to_state :: String,
  write    :: String,
  action   :: String
  } deriving (Generic, Show)

data Config = Config {
  name        :: String,
  alphabet    :: [String]
  blank       :: String,
  states      :: [String],
  initial     :: String,
  finals      :: [String],
  transitions :: [(String, [Transition])]
} deriving (Generic, Show)
