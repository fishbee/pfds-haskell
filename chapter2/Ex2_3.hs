-- Exercise 2.3
--
-- A version of the insert function for UnbalancedSet that does not copy the
-- given set if it is asked to insert an element that is already present in
-- that set. The instructions in PFDS specify using an exception for the
-- control flow, but a Maybe monad seems more Haskell-ish.

module Ex2_3 (insert) where
import UnbalancedSet hiding (insert)

insertCond :: Ord a => a -> UnbalancedSet a -> Maybe (UnbalancedSet a)
insertCond x E = return (T E x E)
insertCond x s@(T a y b) = do
  if x < y then do
      left <- insertCond x a
      return (T left y b)
  else do
    if x > y then do
      right <- insertCond x b
      return (T a y right)
    else fail "Element already in set"

insert x s =
  case insertCond x s of
    Nothing -> s
    Just res -> res

