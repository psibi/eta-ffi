{-#LANGUAGE MagicHash#-}
{-#LANGUAGE FlexibleContexts#-}
{-#LANGUAGE TypeFamilies#-}
{-#LANGUAGE DataKinds#-}

module FFI where

import Data.Int (Int64)

data {-# CLASS "java.util.Calendar" #-} Calendar = Calendar (Object# Calendar)

foreign import java unsafe "@static @field java.util.Calendar.YEAR" yEAR :: Int

foreign import java unsafe "@static eta.examples.Utils.getClockTimePrim" getClockTimePrim :: Int64

foreign import java unsafe "@static eta.examples.Utils.getTimeInUTC" getTimeInUTC :: Int64 -> Calendar

foreign import java unsafe "@static eta.examples.Utils.getTZ" getTZ :: Calendar -> JString

foreign import java unsafe "@static eta.examples.Utils.getNames" getNames :: StringArray

type instance Inherits JString = '[Object]
type instance Inherits StringArray = '[Object]

-- https://docs.oracle.com/javase/7/docs/api/java/lang/reflect/Array.html#getLength(java.lang.Object)
foreign import java unsafe "@static java.lang.reflect.Array.getLength" getLength :: (Extends a Object) => a -> Int

-- https://docs.oracle.com/javase/7/docs/api/java/lang/reflect/Array.html#newInstance(java.lang.Class,%20int)
foreign import java unsafe "@static java.lang.reflect.Array.newInstance" newArray :: JClass -> Int -> Object

-- https://docs.oracle.com/javase/7/docs/api/java/lang/reflect/Array.html#get(java.lang.Object,%20int)
foreign import java unsafe "@static java.lang.reflect.Array.get" arrayGet :: (Extends a Object) => a -> Int -> Object 

conv :: StringArray -> [JString] 
conv arr = map (unsafeCast . arrayGet arr') [0..len - 1] 
    where len = getLength arr
          arr' = newArray (getClass "java/lang/String") len
