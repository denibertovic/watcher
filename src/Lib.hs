module Lib
    ( WatcherArgs
    , watcher
    , watch
    , runCmd
    ) where

import           Control.Concurrent  (threadDelay)
import           Control.Monad
import qualified Data.Text           as T
import           Options.Applicative
import           System.INotify
import           Turtle              (ExitCode, shell)



data WatcherArgs = WatcherArgs
            { file    :: FilePath
            , command :: String
            }

watcher :: Parser WatcherArgs
watcher = WatcherArgs
     <$> strOption
         ( long "file"
        <> metavar "PATH"
        <> help "Absolute path to file to watch for changes" )
     <*> strOption
         ( long "command"
        <> metavar "COMMAND"
        <> help "Command to run when file changes" )

runCmd :: T.Text -> IO ExitCode
runCmd c = shell c empty

watch :: WatcherArgs -> IO ()
watch (WatcherArgs f c) = withINotify $ \inotify -> do
        print "Watching file:"
        print f
        _ <- addWatch inotify [Modify] f (handleEvent f)
        forever $ threadDelay (10 * microsecsPerSec)
    where
        handleEvent :: FilePath -> Event -> IO ()
        handleEvent f e = do
                    _ <- runCmd $ T.pack c
                    return ()

        microsecsPerSec = 1000000
watch _ = return ()

