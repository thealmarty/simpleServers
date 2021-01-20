{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_status_server (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/marty/projects/Hasura/status-server/.stack-work/install/x86_64-linux-tinfo6/2b814168273380d9d094d1afcf62dfd8d97a1fd9236acfd43ddb7c26d2ca3891/8.6.5/bin"
libdir     = "/home/marty/projects/Hasura/status-server/.stack-work/install/x86_64-linux-tinfo6/2b814168273380d9d094d1afcf62dfd8d97a1fd9236acfd43ddb7c26d2ca3891/8.6.5/lib/x86_64-linux-ghc-8.6.5/status-server-0.1.0.0-AYkhyaGP3kc7Mz3BHYsBd7-status-server-exe"
dynlibdir  = "/home/marty/projects/Hasura/status-server/.stack-work/install/x86_64-linux-tinfo6/2b814168273380d9d094d1afcf62dfd8d97a1fd9236acfd43ddb7c26d2ca3891/8.6.5/lib/x86_64-linux-ghc-8.6.5"
datadir    = "/home/marty/projects/Hasura/status-server/.stack-work/install/x86_64-linux-tinfo6/2b814168273380d9d094d1afcf62dfd8d97a1fd9236acfd43ddb7c26d2ca3891/8.6.5/share/x86_64-linux-ghc-8.6.5/status-server-0.1.0.0"
libexecdir = "/home/marty/projects/Hasura/status-server/.stack-work/install/x86_64-linux-tinfo6/2b814168273380d9d094d1afcf62dfd8d97a1fd9236acfd43ddb7c26d2ca3891/8.6.5/libexec/x86_64-linux-ghc-8.6.5/status-server-0.1.0.0"
sysconfdir = "/home/marty/projects/Hasura/status-server/.stack-work/install/x86_64-linux-tinfo6/2b814168273380d9d094d1afcf62dfd8d97a1fd9236acfd43ddb7c26d2ca3891/8.6.5/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "status_server_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "status_server_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "status_server_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "status_server_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "status_server_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "status_server_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
