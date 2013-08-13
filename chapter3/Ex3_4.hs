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


-- 3.4(d)
--
-- The original version of the merge function requires that the children of a
-- node are evaluated before that node can be used (this is due the fact that
-- to compute the rank of a node, the rank of its right child must be computed
-- first). In the version of merge defined above, the size and value at a node
-- are known without requiring the evaluation of the children of that node.
-- This means that, in a lazy language (like Haskell), the above version of
-- merge can require less computation (if some parts of the resulting heap will
-- never be traversed).
--
-- A similar observation applies to environments that support access to data
-- structures by concurrently running threads. If one thread needs to use the
-- result of a call to merge by another thread, the former could start its
-- computation without waiting for the entire merge to be completed.

