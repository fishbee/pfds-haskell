-- Exercise 2.1
--
-- suffixes
-- A function that takes a list, and returns all the suffixes of that list, in
-- order of decreasing length. Example:
-- suffixes [1,2,3,4] = [[1,2,3,4],[2,3,4],[3,4],[4],[]]
--
-- Implemented as single recursion on given list, so for a list xs of length n,
-- ExecTime(suffixes xs) = n * ExecTime(cons) = O(n)
-- Space(suffixes xs) = n * Space(x) + Space(suffixes []) = O(n)

module Ex2_1 (suffixes,sampleList) where

suffixes [] = [[]]
suffixes l@(x:xs) = l : suffixes xs

sampleList = [1,2,3,4]

