-- Exercise 2.2
--
-- A version of the member function for UnbalancedSet that does at most d+1
-- comparisions (where d is the maximum depth of the tree). This is done by
-- keeping track of a candidate element that *might* be equal to the one we're
-- looking for, and only doing a direct comparison at the bottom of a tree.


module Ex2_2 (member) where
import UnbalancedSet hiding (member)

memoMember x E memo = x == memo
memoMember x (T a y b) memo =
  if x < y then memoMember x a memo
  else memoMember x b y

member _ E = False
member x (T a y b) =
  if x < y then member x a
  else memoMember x b y

