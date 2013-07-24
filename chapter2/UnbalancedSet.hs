-- Unbalanced set definition as in PFDS Appendix A, p 203

{-# OPTIONS_GHC -XMultiParamTypeClasses #-}
{-# OPTIONS_GHC -XFlexibleInstances #-}

module UnbalancedSet(UnbalancedSet(E, T), empty, member, insert, sampleSet) where
import Set

data UnbalancedSet a =
  E |
  T (UnbalancedSet a) a (UnbalancedSet a)
  deriving Show

instance Ord a => Set UnbalancedSet a where
  empty = E
  
  member _ E = False
  member x (T a y b) =
    if x < y then member x a
    else if x > y then member x b else True
  
  insert x E = T E x E
  insert x s@(T a y b) =
    if x < y then T (insert x a) y b
    else if x > y then T a y (insert x b) else s


sampleSet :: UnbalancedSet Char
sampleSet = foldl (flip insert) E ['d', 'b', 'a', 'c', 'g', 'f', 'h']

