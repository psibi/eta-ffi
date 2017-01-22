{-#LANGUAGE MultiParamTypeClasses#-}
{-#LANGUAGE MagicHash#-}

module Main where

import FFI
import GHC.Pack (unpackCString)
import Data.Proxy
import Java
import Data.Int

-- main1 :: IO ()
-- main1 = do
--   print yEAR
--   let ctime = getClockTimePrim
--   print ctime
--   let cal = getTimeInUTC ctime
--       tz = getTZ cal
--   print $ unpackCString tz
--   let names = getNames
--   print $ map unpackCString (conv names)

-- newArr :: Java Int64 
-- newArr = do
--   anew 3
--   aset 0 1
--   aset 1 2
--   aset 2 3
--   aget 1

main :: IO ()
main = do
  let x = someLongExample
  print $ getLong x 1
  
--   item <- java newArr
--   print item
    
  
  
