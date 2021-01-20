module Main where
import           Control.Concurrent         (forkIO, threadDelay)
import           Control.Monad              (forever)
import           Data.Aeson                 (ToJSON, encode)
import qualified Data.ByteString.Lazy.Char8 as BS (unpack)
import           Data.IORef
import           Data.Text                  (Text, pack)
import           GHC.Generics               (Generic)
import qualified Network.WebSockets         as WS

data Metrics = Metrics {
      active :: Int --number of active workers
    , idle   :: Int --number of idle workers
    } deriving (Generic, Show)

instance ToJSON Metrics

initState :: Metrics --initial metrics/state
initState = Metrics {active = 0, idle = 9999999999999999}

main :: IO ()
main = do
    state <- newIORef initState --put the initial state in a ref in the IO monad
    _ <- forkIO (application state) --start a thread that updates the state
    WS.runServer "127.0.0.1" 8080 $ statusSocket state --run a server that sends the state

application :: IORef Metrics -> IO () --the application that writes the state to the ref
application metrics =
    forever $ do
          threadDelay 950000 --delay in number of microseconds, has to be > 95 or more
          safeUpdate metrics (\m -> m { active = active m + 1, idle = idle m - 1})

--update the metrics in the ref safely under multithread
safeUpdate :: IORef Metrics -> (Metrics -> Metrics) -> IO ()
safeUpdate metrics changeMetrics =
    atomicModifyIORef' metrics (\m -> (changeMetrics m, ()))

statusSocket :: IORef Metrics -> WS.ServerApp
statusSocket state pending = do
    conn <- WS.acceptRequest pending
    WS.withPingThread conn 30 (return ()) $ forever $ do
        threadDelay 1000000
        currentState <- readIORef state --read the state
        WS.sendTextData conn (recordToText currentState) --send the state

recordToText :: Metrics -> Text
recordToText = pack . BS.unpack . encode
