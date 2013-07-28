-- Map declaration as in PFDS Appendix A, p 204

{-# OPTIONS_GHC -XMultiParamTypeClasses #-}

module FiniteMap(FiniteMap(..)) where

-- m: concrete map type, k: key type, a: value type
-- Note: changed the name of the lookup function to "find", to avoid having
-- hide "lookup" in Prelude.
class FiniteMap m k where
  empty :: m k a
  bind  :: k -> a -> m k a -> m k a
  find  :: k -> m k a -> Maybe a

