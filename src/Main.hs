module Main where

import FFI
import GHC.Pack (unpackCString)

main :: IO ()
main = do
  print yEAR

  let ctime = getClockTimePrim
  print ctime

  let cal = getTimeInUTC ctime
      tz = getTZ cal
           
  print $ unpackCString tz
  
  