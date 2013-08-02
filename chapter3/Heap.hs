-- Heap declaration similar to that in PFDS Appendix A, p 197, but using Maybe
-- for operations that might fail.

{-# OPTIONS_GHC -XMultiParamTypeClasses #-}

module Heap(Heap(..)) where

class Heap h where
  empty :: Ord a => h a
  isEmpty :: Ord a => h a -> Bool
  insert :: Ord a => a -> h a -> h a
  merge :: Ord a => h a -> h a -> h a
  findMin :: Ord a => h a -> Maybe a
  deleteMin :: Ord a => h a -> Maybe (h a)

