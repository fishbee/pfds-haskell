-- Exercise 3.4: Weight-biased leftist heaps (heaps where the size of any left
-- child of a node is at least as large as the size of its right sibling).

-- 3.4(a)
--
-- Prove that the right spine of a weight-biased leftist heap contains at most
-- floor(lg(n+1)) elements.
--
-- By definition, the longest right spine occurs in a heap represented by a
-- perfectly balanced binary tree, where all paths to an empty node contain
-- the same number of elements d (d being the depth of the tree). The number of
-- elements n is given by
--
-- n = (2^d) - 1
--
-- which means that
--
-- d = lg(n+1)
--
-- For an unbalanced heap of size n, the right spine must necessarily contain
-- an integer number of elements less than lg(n+1), i.e. floor(lg(n+1)).


-- 3.4(b)
--
-- Modify the definition of the leftist heap data structure to implement
-- weight-biased leftist heaps instead. See WBLHeap.hs


-- 3.4(c)
--
-- A version of the merge function for weight-biased leftist heaps that
-- performs the merge in a single top-down pass (rather than applying makeT
-- from the bottom up, like the original merge function).

module Ex3_4 (merge) where
import WBLHeap hiding (merge)

merge h1 E = h1
merge E h2 = h2
merge h1@(T _ x _ _) h2@(T _ y _ _) =
  let
    mergeChildWithHeap (T s z a b) h =
      if size a >= (size b + size h) then T (s + size h) z a (merge b h)
      else T (s + size h) z (merge a h) b
  in
    if x <= y then mergeChildWithHeap h1 h2
    else mergeChildWithHeap h2 h1

