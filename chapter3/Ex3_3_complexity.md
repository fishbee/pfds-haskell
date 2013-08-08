Exercise 3.3: Complexity
========================

This is an attempt to show that the execution time of the fromList function in Exercise 3.3 (see Ex3_3.hs) is O(n).

Let T<sub>m</sub>(s) be the execution time of the merge function in LeftistHeap.hs, where s is the size of the larger of the two sets being merged. Similarly, let T<sub>mhl</sub>(n) be the execution tims of the mergeHeapList function in Ex3_3.hs, where n is the length of the list being processed.

Calling mergeHeapList on a list of n one-element heaps results in the merge function being called up to n times. The first pass (i.e. the first call to the mergePairs function) involves n/2 calls to merge with heaps of size 1, the second pass consists of n/4 calls to merge heaps of size 2, etc, with lg(n) passes in total. In other words, we have

![T_{mhl}(n)=\sum_{s=1}^{\lg n} \frac{n}{2^s} T_m(2^{s-1})](tmhl0.gif)

Since T<sub>m</sub>(n) is O(log n), we get, for some constant c,

![T_{mhl}(n) \leq \sum_{s=1}^{\lg n} \frac{c n \lg(2^{s-1})}{2^s}](tmhl1.gif)

Simplifying the above:

![T_{mhl}(n) \leq  c n \sum_{s=1}^{\lg n} \frac{s-1}{2^s}](tmhl2.gif)

For T<sub>mhl</sub> to be O(n), we need for the sum above to be bounded by a constant. Applying the [ratio test](https://en.wikipedia.org/wiki/Ratio_test) by taking the ratio of two adjacent terms in a series to see if the sum converges as n tends to infinity, we get

![\frac{s}{2^{s+1}} / \frac{s - 1}{2^s} = \frac{2^s s}{2^{s+1}(s - 1)} = \frac{s}{2(s -1)}=\frac{1}{2} + \frac{1}{s}](ratio.gif)

As s tends to infinity, the ratio tends to 1/2, so the sum converges. (In fact, [pluging it into Wolfram Alpha](http://www.wolframalpha.com/input/?i=sum+of+%28x-1%29%2F2^x) tells us that the sum converges to the starting value, so starting at s = 1, the sum tends to 1).

In other words,

![T_{mhl}(n) \leq c k n](tmhl3.gif)

Where c and k are constants, so T<sub>mhl</sub>(n) is O(n). Since fromList only does O(n) preprocessing on a list before passing it on to mergeHeapList, the execution time of fromList is also O(n).

Shoutout: LaTeX to GIF conversion done with [CodeCogs](http://www.codecogs.com/latex/htmlequations.php).


