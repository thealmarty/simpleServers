{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_status_client (
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

bindir     = "/home/marty/projects/Hasura/status-client/.stack-work/install/x86_64-linux-tinfo6/5d0c58175e5d9fa57bba367e6482bba0fa462fb4a04ed0276be309995019943e/8.6.5/bin"
libdir     = "/home/marty/projects/Hasura/status-client/.stack-work/install/x86_64-linux-tinfo6/5d0c58175e5d9fa57bba367e6482bba0fa462fb4a04ed0276be309995019943e/8.6.5/lib/x86_64-linux-ghc-8.6.5/status-client-0.1.0.0-HXfBN13yIgpJNyPuEHZcHE"
dynlibdir  = "/home/marty/projects/Hasura/status-client/.stack-work/install/x86_64-linux-tinfo6/5d0c58175e5d9fa57bba367e6482bba0fa462fb4a04ed0276be309995019943e/8.6.5/lib/x86_64-linux-ghc-8.6.5"
datadir    = "/home/marty/projects/Hasura/status-client/.stack-work/install/x86_64-linux-tinfo6/5d0c58175e5d9fa57bba367e6482bba0fa462fb4a04ed0276be309995019943e/8.6.5/share/x86_64-linux-ghc-8.6.5/status-client-0.1.0.0"
libexecdir = "/home/marty/projects/Hasura/status-client/.stack-work/install/x86_64-linux-tinfo6/5d0c58175e5d9fa57bba367e6482bba0fa462fb4a04ed0276be309995019943e/8.6.5/libexec/x86_64-linux-ghc-8.6.5/status-client-0.1.0.0"
sysconfdir = "/home/marty/projects/Hasura/status-client/.stack-work/install/x86_64-linux-tinfo6/5d0c58175e5d9fa57bba367e6482bba0fa462fb4a04ed0276be309995019943e/8.6.5/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "status_client_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "status_client_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "status_client_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "status_client_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "status_client_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "status_client_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
