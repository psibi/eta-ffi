{-#LANGUAGE MagicHash#-}
{-#LANGUAGE FlexibleContexts#-}
{-#LANGUAGE TypeFamilies#-}
{-#LANGUAGE DataKinds#-}

module FFI where

import Data.Int (Int64)
import Data.Proxy

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

-- https://docs.oracle.com/javase/7/docs/api/java/lang/reflect/Array.html#get(java.lang.Object,%20int)
foreign import java unsafe "@static java.lang.reflect.Array.get" arrayGet :: (Extends a Object) => a -> Int -> Object 

conv :: JStringArray -> [JString] 
conv arr = map (unsafeCast . arrayGet arr) [0..len - 1] 
    where len = getLength arr
          arr' = newArray (getClass (Proxy :: Proxy JString)) len


-- Enum Example

data {-# CLASS "java.nio.file.attribute.PosixFilePermission" #-} PosixFilePermission = PosixFilePermission (Object# PosixFilePermission)

instance Class PosixFilePermission where
  unobj (PosixFilePermission x) = x
  obj = PosixFilePermission

foreign import java unsafe "@static @field java.nio.file.attribute.PosixFilePermission.OWNER_READ" oWNER_READ :: PosixFilePermission

data {-# CLASS "java.lang.Enum" #-} JEnum a = JEnum (Object# (JEnum a)) 

instance Class (JEnum a) where
  unobj (JEnum x) = x
  obj = JEnum

type instance Inherits PosixFilePermission = '[JEnum PosixFilePermission]

foreign import java unsafe name :: (Extends a (JEnum a)) => a -> JString

-- Set Example 

data {-# CLASS "java.nio.file.Paths" #-} Paths = Paths (Object# Paths) 
data {-# CLASS "java.nio.file.Path" #-} Path = Path (Object# Path) 
data {-# CLASS "java.util.Set" #-} JSet a = JSet (Object# (JSet a))

foreign import java unsafe "@static java.nio.file.Paths.get" get :: JString -> Path

-- http://docs.oracle.com/javase/7/docs/api/java/nio/file/Files.html#setPosixFilePermissions%28java.nio.file.Path,%20java.util.Set%29
foreign import java unsafe "@static java.nio.file.Files.setPosixFilePermissions" setPosixFilePermissions :: JString -> Path -> IO Path
