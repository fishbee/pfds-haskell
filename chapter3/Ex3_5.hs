-- Exercise 3.5
--
-- A version of the findMin function for binomial heaps. This operates directly
-- on the heap, rather than using removeMinTree.

module Ex3_5 (findMin) where
import BinomialHeap hiding (findMin)

testMinCandidate minCand [] = minCand
testMinCandidate minCand (t:ts) =
  if minCand <= root t then testMinCandidate minCand ts
  else testMinCandidate (root t) ts

findMin (BH []) = Nothing
findMin (BH (t:ts)) = Just (testMinCandidate (root t) ts)

