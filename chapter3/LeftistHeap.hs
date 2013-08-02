-- Leftist heap definition similar to that in PFDS Appendix A, p 197, but using
-- Maybe for operations that might fail.

{-# OPTIONS_GHC -XMultiParamTypeClasses #-}
{-# OPTIONS_GHC -XFlexibleInstances #-}

module LeftistHeap(
  LeftistHeap(E, T), empty, isEmpty, insert, merge,
  findMin, deleteMin, rank, makeT, sampleHeap
  ) where
import Heap

data LeftistHeap a =
  E |
  T Int a (LeftistHeap a) (LeftistHeap a)
  deriving Show

rank E = 0
rank (T r _ _ _) = r

makeT x a b =
  if rank a >= rank b then T ((rank b) + 1) x a b
  else T ((rank a) + 1) x b a

instance Heap LeftistHeap where
  empty = E
  
  isEmpty E = True
  isEmpty _ = False
  
  merge h1 E = h1
  merge E h2 = h2
  merge h1@(T _ x a1 b1) h2@(T _ y a2 b2) =
    if x <= y then makeT x a1 (merge b1 h2)
    else makeT y a2 (merge h1 b2)
  
  insert x h = merge (T 1 x E E) h
  
  findMin E = Nothing
  findMin (T _ x _ _) = Just x
  
  deleteMin E = Nothing
  deleteMin (T _ x a b) = Just (merge a b)


-- Sample data: a heap containing characters.
sampleHeap :: LeftistHeap Char
sampleHeap = foldl (\h -> \c -> insert c h) E ['a', 'b', 'c', 'd', 'g', 'f', 'h']

