-- Exercise 2.5

module Ex2_5 (Tree(E, T), complete, create) where

data Tree a = E | T (Tree a) a (Tree a) deriving Show

-- Exercise 2.5 (a)
--
-- complete
-- A function that returns a binary tree of depth d, with the given element x
-- stored at every node. Since the left and right sub-trees at every node are
-- identical, they are represented by the same tree.
complete _ 0 = E
complete x d =
  let subTree = complete x (d - 1)
  in T subTree x subTree


-- Exercise 2.5 (b)
--
-- A function create that returns a binary tree of size n, with the given
-- element x stored at every node. The tree will be as balanced as possible;
-- at any node, the left and right sub-trees differ in size by at most 1.
-- The create function is implemented using mutual recursion with a function
-- create2, which returns a pair of trees, with the second of the trees having a
-- size one greater than the first.

-- create2 create x m
--
-- Mutually recursive helper for create. Returns two trees, of sizes m and m+1.
-- Arguments:
-- create: function that returns a single tree with a specified number of elements.
-- x: element to put at every node in created trees.
-- m: size of the smaller of the two trees that will be returned.
create2 _ x 0 = (E, T E x E)
create2 create x m =
  let bigTree = create x (div (m + 1) 2)
      smallTree = create x (div (m - 1) 2)
  in
    if mod m 2 == 0 then (T smallTree x bigTree, T bigTree x bigTree)
    else (T smallTree x smallTree, T smallTree x bigTree)

create _ 0 = E
create x n =
  let (smallTree, bigTree) = create2 create x (div (n - 1) 2)
  in
    if mod n 2 == 0 then (T smallTree x bigTree)
    else (T smallTree x smallTree)

