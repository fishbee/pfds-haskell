-- Binomial heap definition similar to that in PFDS Appendix A, p 198, but using
-- Maybe for operations that might fail.

{-# OPTIONS_GHC -XMultiParamTypeClasses #-}
{-# OPTIONS_GHC -XFlexibleInstances #-}

module BinomialHeap(
  BinomialHeap(BH), root, rank, empty, isEmpty, insert, merge, findMin, deleteMin,
  sampleHeap
  ) where
import Heap

data Tree a = NODE Int a [Tree a] deriving Show
newtype BinomialHeap a = BH [Tree a] deriving Show

rank (NODE r x c) = r
root (NODE r x c) = x

link t1@(NODE r x1 c1) t2@(NODE _ x2 c2) =
  if x1 <= x2 then NODE (r + 1) x1 (t2:c1) else NODE (r + 1) x2 (t1:c2)

insTree t [] = [t]
insTree t ts@(t':ts') =
  if rank t < rank t' then t : ts else insTree (link t t') ts'

mrg ts1 [] = ts1
mrg [] ts2 = ts2
mrg ts1@(t1:ts1') ts2@(t2:ts2')
  | rank t1 < rank t2 = t1 : (mrg ts1' ts2)
  | rank t2 < rank t1 = t2 : (mrg ts1 ts2')
  | otherwise = insTree (link t1 t2) (mrg ts1' ts2')

removeMinTree [] = Nothing
removeMinTree [t] = Just (t, [])
removeMinTree (t:ts) = do
  (t', ts') <- removeMinTree ts
  if root t < root t' then return (t, ts) else return (t', t:ts')

instance Heap BinomialHeap where
  empty = BH []
  
  isEmpty (BH ts) = null ts
  
  insert x (BH ts) = BH (insTree (NODE 0 x []) ts)
  
  merge (BH ts1) (BH ts2) = BH (mrg ts1 ts2)
  
  findMin (BH ts) = do
    (t, _) <- removeMinTree ts
    return (root t)
  
  deleteMin (BH ts) = do
    (NODE _ x ts1, ts2) <- removeMinTree ts
    return (BH (mrg (reverse ts1) ts2))

sampleHeap :: BinomialHeap Char
sampleHeap = foldl (\h -> \c -> insert c h) empty ['a', 'b', 'c', 'd', 'g', 'f', 'h']

