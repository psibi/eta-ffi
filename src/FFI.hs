{-#LANGUAGE MagicHash#-}

module FFI where

import Data.Int (Int64)

data {-# CLASS "java.util.Calendar" #-} Calendar = Calendar (Object# Calendar)

foreign import java unsafe "@static @field java.util.Calendar.YEAR" yEAR :: Int

foreign import java unsafe "@static eta.examples.Utils.getClockTimePrim" getClockTimePrim :: Int64

foreign import java unsafe "@static eta.examples.Utils.getTimeInUTC" getTimeInUTC :: Int64 -> Calendar

foreign import java unsafe "@static eta.examples.Utils.getTZ" getTZ :: Calendar -> JString
