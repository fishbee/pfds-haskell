-- Exercise 3.2
-- A version of the insert function for leftist heaps implemented not in terms
-- of the merge function.

module Ex3_2 (insert) where
import LeftistHeap hiding (insert)

insert x E = T 1 x E E
insert x (T _ y a b) =
  if x <= y then makeT x a (insert y b)
  else makeT y (insert x a) b

