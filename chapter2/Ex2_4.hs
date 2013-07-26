-- Exercise 2.4
--
-- A version of the insert function for UnbalancedSet that uses the ideas from
-- Exercises 2.2 and 2.3. The given set is not copied when inserting an element
-- that is already in the set; the maximum number of comparisons is reduced by
-- keeping track of any candidate element that might be equal to the element
-- being inserted (and only comparing for equality at the bottom of a tree).

module Ex2_4 (insert) where
import UnbalancedSet hiding (insert)

insertCondMemo :: Ord a => a -> UnbalancedSet a -> a -> Maybe (UnbalancedSet a)
insertCondMemo x E memo = do
  if x == memo then fail "Element already in set"
  else return (T E x E)
insertCondMemo x (T a y b) memo = do
  if x < y then do
    left <- insertCondMemo x a memo
    return (T left y b)
  else do
    right <- insertCondMemo x b memo
    return (T a y right)

insertFindMemo x E = return (T E x E)
insertFindMemo x (T a y b) = do
  if x < y then do
    left <- insertFindMemo x a
    return (T left y b)
  else do
    right <- insertCondMemo x b y
    return (T a y right)

insert x s =
  case insertFindMemo x s of
    Nothing -> s
    Just res -> res

