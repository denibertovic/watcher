{-# OPTIONS -Wall #-}

module Main where

import           Lib
import           Options.Applicative


main :: IO ()
main = execParser opts >>= watch
  where
    opts = info (helper <*> watcher)
      ( fullDesc
     <> progDesc "Watches files for changes and executes a command on change"
     <> header "watcher - File INotify wathcer" )

