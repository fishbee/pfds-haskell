-- Exercise 2.6
--
-- UnbalancedMap: an adaptation of UnbalancedSet to the FiniteMap type class.

{-# OPTIONS_GHC -XMultiParamTypeClasses #-}
{-# OPTIONS_GHC -XFlexibleInstances #-}

module Ex2_6 (UnbalancedMap(E, T), empty, find, bind, sampleMap) where
import FiniteMap

data UnbalancedMap k a =
  E |
  T (UnbalancedMap k a) k a (UnbalancedMap k a)
  deriving Show

-- Basic implementation of map functions, similar to those in UnbalancedSet.
-- Ideas from Exercises 2.2-2.4 should be straightforward to incorporate.
instance Ord k => FiniteMap UnbalancedMap k where
  empty = E
  
  find _ E = Nothing
  find k (T a j v b) =
    if k < j then find k a
    else if k > j then find k b else Just v
  
  bind k v E = (T E k v E)
  bind k v (T a j u b) =
    if k < j then T (bind k v a) j u b
    else if k > j then T a j u (bind k v b) else T a k v b


-- Sample data: a map containing strings keyed by their first characters.
sampleMap :: UnbalancedMap Char [Char]
sampleMap = foldl (\m -> \s@(c:_) -> bind c s m) E
  ["badger", "mushroom", "snake", "unicorn", "platipus", "armadillo"]

