-- Exercise 3.3
--
-- fromList
-- A function that takes a list of elements, and returns a leftist heap
-- containing those elements. The heap is created by first turning the list of
-- elements into a list of one-element heaps, and then performing repeated
-- passes of merging adjacent pairs of heaps in that list, until only a single
-- heap remains.
--
-- See Ex3_3_complexity.md for a discussion of why the execution time of
-- fromList is O(n).

module Ex3_3 (fromList, sampleList) where
import LeftistHeap

mergePairs (h1:h2:hs) = (merge h1 h2):(mergePairs hs)
mergePairs hs = hs

mergeHeapList [] = E
mergeHeapList (h:[]) = h
mergeHeapList hs = mergeHeapList (mergePairs hs)

fromList xs = mergeHeapList (map (\x -> T 1 x E E) xs)

sampleList = ['a', 'b', 'c', 'd', 'g', 'f', 'h']

