{-# LANGUAGE DeriveGeneric #-}
module Types where

import GHC.Generics
import Data.Aeson
import Data.Map

data Transition = Transition {
  read     :: String,
  to_state :: String,
  write    :: String,
  action   :: String
  } deriving (Generic, Show)
instance FromJSON Transition

data TransitionMap = TransitionMap {
  nameT :: String,
  list :: [Transition]
} deriving (Generic, Show)
instance FromJSON TransitionMap

data Config = Config {
  name        :: String,
  alphabet    :: [String],
  blank       :: String,
  states      :: [String],
  initial     :: String,
  finals      :: [String],
  -- transitions :: [TransitionMap]
  transitions :: Map String [Transition]
} deriving (Generic, Show)
instance FromJSON Config