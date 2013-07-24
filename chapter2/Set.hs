-- Set declaration from PFDS Appendix A, p 202

{-# OPTIONS_GHC -XMultiParamTypeClasses #-}

module Set(Set(..)) where

class Set s a where
  empty  :: s a
  insert :: a -> s a -> s a
  member :: a -> s a -> Bool

