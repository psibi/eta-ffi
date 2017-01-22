{-#LANGUAGE MagicHash#-}
{-#LANGUAGE FlexibleContexts#-}
{-#LANGUAGE TypeFamilies#-}
{-#LANGUAGE DataKinds#-}

module FFI where

import Data.Int (Int64)
import Data.Proxy
import Java

data {-# CLASS "java.util.Calendar" #-} Calendar = Calendar (Object# Calendar)

foreign import java unsafe "@static @field java.util.Calendar.YEAR" yEAR :: Int

foreign import java unsafe "@static eta.examples.Utils.getClockTimePrim" getClockTimePrim :: Int64

foreign import java unsafe "@static eta.examples.Utils.getTimeInUTC" getTimeInUTC :: Int64 -> Calendar

foreign import java unsafe "@static eta.examples.Utils.getTZ" getTZ :: Calendar -> JString

foreign import java unsafe "@static eta.examples.Utils.getNames" getNames :: JStringArray

-- https://docs.oracle.com/javase/7/docs/api/java/lang/reflect/Array.html#getLength(java.lang.Object)
foreign import java unsafe "@static java.lang.reflect.Array.getLength" getLength :: (Extends a Object) => a -> Int

-- https://docs.oracle.com/javase/7/docs/api/java/lang/reflect/Array.html#newInstance(java.lang.Class,%20int)
foreign import java unsafe "@static java.lang.reflect.Array.newInstance" newArray :: JClass a -> Int -> Object

-- https://docs.oracle.com/javase/7/docs/api/java/lang/reflect/Array.html#setLong(java.lang.Object,%20int,%20long)
foreign import java unsafe "@static java.lang.reflect.Array.setLong" setLong :: (Extends a Object) => a -> Int -> Int64 -> ()

-- https://docs.oracle.com/javase/7/docs/api/java/lang/reflect/Array.html#get(java.lang.Object,%20int)
foreign import java unsafe "@static java.lang.reflect.Array.get" arrayGet :: (Extends a Object) => a -> Int -> Object 

foreign import java unsafe "@static java.lang.reflect.Array.set" arraySet :: (Extends a Object) => a -> Int -> Object -> ()

conv :: JStringArray -> [JString] 
conv arr = map (unsafeCast . arrayGet arr) [0..len - 1] 
    where len = getLength arr
          arr' = newArray (getClass (Proxy :: Proxy JString)) len

data {-# CLASS "java.lang.Long[]" #-} JLongs = JLongs (Object# JLongs)

foreign import java unsafe "@static java.lang.reflect.Array.getLong" getLong :: (Extends a Object) =>  a -> Int -> Int64
foreign import java unsafe "@static eta.examples.Utils.someLongExample" someLongExample :: JLongArray

foreign import java unsafe "@static eta.examples.Utils.someLongExample2" someLongExample2 :: JLongArray -> JLongArray
