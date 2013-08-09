-- Exercise 3.4(b)
-- Implementation of weight-biased leftist heaps to mirror that of "plain"
-- leftist heaps in LeftistHeap.hs (weight-biased leftist heaps are heaps where
-- the size of the left child of a node is at least as large as the size of its
-- right sibling).

{-# OPTIONS_GHC -XMultiParamTypeClasses #-}
{-# OPTIONS_GHC -XFlexibleInstances #-}

module WBLHeap(
  WBLHeap(E, T), empty, isEmpty, insert, merge,
  findMin, deleteMin, size, makeT, sampleHeap
  ) where
import Heap

data WBLHeap a =
  E |
  T Int a (WBLHeap a) (WBLHeap a)
  deriving Show

size E = 0
size (T s _ _ _) = s

makeT x a b =
  let newSize = size a + size b + 1
  in
    if size a >= size b then T newSize x a b
    else T newSize x b a

instance Heap WBLHeap where
  empty = E
  
  isEmpty E = True
  isEmpty _ = False
  
  merge h1 E = h1
  merge E h2 = h2
  merge h1@(T s1 x a1 b1) h2@(T s2 y a2 b2) =
    if x <= y then makeT x a1 (merge b1 h2)
    else makeT y a2 (merge h1 b2)
  
  insert x h = merge (T 1 x E E) h
  
  findMin E = Nothing
  findMin (T _ x _ _) = Just x
  
  deleteMin E = Nothing
  deleteMin (T _ x a b) = Just (merge a b)

-- Sample data: a heap containing characters.
sampleHeap :: WBLHeap Char
sampleHeap = foldl (\h -> \c -> insert c h) E ['a', 'b', 'c', 'd', 'g', 'f', 'h']

