{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_yesod_bin (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
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
version = Version [1,6,1] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/Users/irinaivakhnenko/.cabal/bin"
libdir     = "/Users/irinaivakhnenko/.cabal/lib/x86_64-osx-ghc-8.10.7/yesod-bin-1.6.1-inplace-yesod"
dynlibdir  = "/Users/irinaivakhnenko/.cabal/lib/x86_64-osx-ghc-8.10.7"
datadir    = "/Users/irinaivakhnenko/.cabal/share/x86_64-osx-ghc-8.10.7/yesod-bin-1.6.1"
libexecdir = "/Users/irinaivakhnenko/.cabal/libexec/x86_64-osx-ghc-8.10.7/yesod-bin-1.6.1"
sysconfdir = "/Users/irinaivakhnenko/.cabal/etc"

getBinDir     = catchIO (getEnv "yesod_bin_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "yesod_bin_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "yesod_bin_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "yesod_bin_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "yesod_bin_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "yesod_bin_sysconfdir") (\_ -> return sysconfdir)




joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
