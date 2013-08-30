-- Exercise 3.6
--
-- A binomial heap implementation that stores rank information at the top level
-- of each binomial tree (since, by definition, the child nodes of a binomial
-- tree node of rank r have ranks r-1,r-2,...,0).

module Ex3_6(
  BinomialTopRankHeap(BH), root, rank, empty, isEmpty, insert, merge,
  findMin, deleteMin, sampleHeap
  ) where
import Heap

data Tree a = NODE a [Tree a] deriving Show
newtype BinomialTopRankHeap a = BH [(Int, Tree a)] deriving Show

rank (r, n) = r
root (r, (NODE x ts)) = x

heapFromChildren (_, NODE _ [t]) acc = (0, t) : acc
heapFromChildren (r, NODE x (t:ts)) acc =
  heapFromChildren (r - 1, NODE x ts) ((r - 1, t) : acc)

link (r, t1@(NODE x1 c1)) (_, t2@(NODE x2 c2)) =
  if x1 <= x2 then (r + 1, NODE x1 (t2:c1)) else (r + 1, NODE x2 (t1:c2))

insTree rt [] = [rt]
insTree rt@(r, t) rts@(rt'@(r', t') : rts') =
  if r < r' then rt : rts else insTree (link rt rt') rts'

mrg rts1 [] = rts1
mrg [] rts2 = rts2
mrg rts1@(rt1 : rts1') rts2@(rt2 : rts2')
  | rank rt1 < rank rt2 = rt1 : (mrg rts1' rts2)
  | rank rt2 < rank rt1 = rt2 : (mrg rts1 rts2')
  | otherwise = insTree (link rt1 rt2) (mrg rts1' rts2')

removeMinTree [] = Nothing
removeMinTree [rt] = Just (rt, [])
removeMinTree (rt:rts) = do
  (rt', rts') <- removeMinTree rts
  if root rt < root rt' then return (rt, rts) else return (rt', rt:rts')

instance Heap BinomialTopRankHeap where
  empty = BH []
  
  isEmpty (BH rts) = null rts
  
  insert x (BH rts) = BH (insTree (0, NODE x []) rts)
  
  merge (BH rts1) (BH rts2) = BH (mrg rts1 rts2)
  
  findMin (BH rts) = do
    (rt, _) <- removeMinTree rts
    return (root rt)
  
  deleteMin (BH rts) = do
    (rt'@(r, NODE x ts), rts') <- removeMinTree rts
    if null ts then return (BH rts')
    else return (BH (mrg (heapFromChildren rt' []) rts'))


sampleHeap :: BinomialTopRankHeap Char
sampleHeap = foldl (\h -> \c -> insert c h) empty ['a', 'b', 'c', 'd', 'g', 'f', 'h']

