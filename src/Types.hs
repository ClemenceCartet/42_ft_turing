{-# LANGUAGE DeriveGeneric #-}
module Types where

import GHC.Generics
import Data.Aeson

data Transition = Transition {
  read     :: String,
  to_state :: String,
  write    :: String,
  action   :: String
  } deriving (Generic, Show)
instance FromJSON Transition

data Config = Config {
  name        :: String,
  alphabet    :: [String],
  blank       :: String,
  states      :: [String],
  initial     :: String,
  finals      :: [String]
  -- transitions :: [(String, [Transition])]
} deriving (Generic, Show)
instance FromJSON Config