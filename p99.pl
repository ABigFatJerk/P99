% 1.01 Find the last element of a list
% my_last(Element, List)
my_last(Element, [Element]).
my_last(Element, [_|T]) :- my_last(Element, T).

my_last_acc(Element, [H|T]) :- my_last_acc(Element, T, H).
my_last_acc(Element, [], Element).
my_last_acc(Element, [H|T], _) :- my_last_acc(Element, T, H).

% 1.02 Find the penultimate element of a list
% penultimate(Element, List)
penultimate(Element, [Element, _]).
penultimate(Element, [_|T]) :- penultimate(Element, T).

penultimate_acc(Element, [H, _|T]) :- penultimate_acc(Element, T, H).
penultimate_acc(Element, [_], Element).
penultimate_acc(Element, [H|T], _) :- penultimate_acc(Element, T, H).

% 1.03 Find the Kth element of a (0-indexed) list
% element_at(Element, List, Position)
element_at(H, [H|_], 0).
element_at(Element, [_|T], Index) :- Index2 is Index-1, element_at(Element, T, Index2).

element_at_acc(Element, List, Position) :- element_at_acc(Element, List, 0, Position).
element_at_acc(H, [H|_], TargetPos, TargetPos).
element_at_acc(E, [_|T], CurrentPos, TargetPos) :- NewCurrentPos is CurrentPos+1, element_at_acc(E, T, NewCurrentPos, TargetPos).

% 1.04 Find the number of elements in a list
% my_length(Length, List).
my_length(0, []).
my_length(Len, [_|T]) :- my_length(Sublen, T), Len is Sublen+1. 

my_length_acc(Length, List) :- my_length_acc(Length, 0, List).
my_length_acc(Length, Length, []).
my_length_acc(Length, CurrentLength, [_|T]) :- NewCurrentLength is CurrentLength+1, my_length_acc(Length, NewCurrentLength, T).

% 1.05 Reverse a list
% my_reverse(List, ReversedList)
my_reverse_acc(List, ReversedList) :- my_reverse_acc(List, [], ReversedList).
my_reverse_acc([], ReversedList, ReversedList).
my_reverse_acc([H|T], CurReverse, ReversedList) :- my_reverse_acc(T, [H|CurReverse], ReversedList).

% 1.06 Determine if a list is a palindrome
palindrome(List) :- my_reverse_acc(List, List).

% 1.07 Flatten a nested list structure
% my_flatten(List, FlatList)
my_flatten([], []).
my_flatten([H|T], FlatList) :- is_list(H), !, my_flatten(H, Hflat), my_flatten(T, Tflat), append(Hflat, Tflat, FlatList).
my_flatten([H|T], [H|Tflat]) :- my_flatten(T, Tflat).

% 1.08 Eliminate consecutive duplicates of list elements
% compress(List, CompressedList).
compress([], []).
compress([X], [X]).
compress([X, X|T], TC) :- compress([X|T], TC).
compress([X, Y|T], [X|TC]) :- X \= Y, compress([Y|T], TC). 

% 1.09 Pack consecutive duplicates of list elements
% pack(List, PackedList).
pack([], []).
pack(List, PackedList) :- pack(List, [], PackedList).
pack([X], Acc, [[X|Acc]]).
pack([X, X|T], Acc, TP) :- pack([X|T], [X|Acc], TP).
pack([X, Y|T], Acc, [[X|Acc]|TP]) :- pack([Y|T], [], TP).

% 1.10 Run length encoding using 1.09 predicate
% encode(List, EncodedList)
calc_lengths([], []).
calc_lengths([[H|HT]|T], [[N,H]|TC]) :- length([H|HT], N), calc_lengths(T, TC).

encode(List, EncodedList) :- pack(List, PackedList), calc_lengths(PackedList, EncodedList).

% 1.11 Run length encoding with special case if N=1
% TODO

% 1.12 Decode a run-length encoding
% TODO

% 1.13 Direct run-length encoding
% TODO

% 1.14 Duplicate the elements of a list
% duplicate(List, DuplicatedList)
duplicate([], []).
duplicate([H|T], [H, H|TD]) :- duplicate(T, TD).

% 1.15 Duplicate the elements of a list the given number of times
% dupN(List, N, NDupedList)
dupEl(E, 1, [E]).
dupEl(E, N, [E|DupedEl]) :- N > 1, N2 is N-1, dupEl(E, N2, DupedEl). 

dupN([], _, []).
dupN([H|T], N, DupedList) :- dupEl(H, N, DupedH), dupN(T, N, DupedT), append(DupedH, DupedT, DupedList). 

% 1.16 Drop every Nth element from a list
% drop(List, N, DroppedList).
drop(List, N, DroppedList) :- N > 1, drop(List, N, N, DroppedList).

drop([], _, _, []).
drop([_|T], 1, N, DroppedT) :- drop(T, N, N, DroppedT).
drop([H|T], X, N, [H|DroppedT]) :- X2 is X-1, drop(T, X2, N, DroppedT). 

% 1.17 Split a list into two parts
% split(List, Size, FirstPart, SecondPart).
split(List, 0, [], List).
split([H|T], Size, [H|T2], SecondPart) :- Size2 is Size - 1, split(T, Size2, T2, SecondPart). 

% Inefficient version (generate-and-test algorithm)
splitGAT(List, Size, FirstPart, SecondPart) :- append(FirstPart, SecondPart, List), length(FirstPart, Size).

% 1.18 Extract a slice from a list.  List is 1-indexed, ends are inclusive
% slice(List, Start, End, Slice).  
% TODO sanity checking on numbers (no negatives, Start and End less than length, Start less than End)
slice(List, Start, End, Slice) :- split(List, End, FirstTwoParts, _), split(FirstTwoParts, Start-1, _, Slice).

% 1.19 Rotate a list N places
% rotate(List, N, RotatedList).
% TODO sanity checking on N
% TODO support negative N
rotate(List, N, RotatedList) :- split(List, N, FirstPart, SecondPart), append(SecondPart, FirstPart, RotatedList).

% 1.20 Remove the Kth element from a list (1-indexed)
% remove_at(Element, List, Index, ResultList).
remove_at(H, [H|T], 1, T).
remove_at(El, [H|T], N, [H|TR]) :- N > 1, N2 is N-1, remove_at(El, T, N2, TR).

% 1.21 Insert an element at a given position in a list (1-indexed)
% insert_at(Element, List, Index, ResultList).
insert_at(El, List, 1, [El|List]).
insert_at(El, [H|T], N, [H|TI]) :- N > 1, N2 is N-1, insert_at(El, T, N2, TI).

% 1.22 Create a list containing all integers in a given range (inclusive of endpoints)
% range(Start, End, ResultList).
% TODO sanity checks on values
range(End, End, [End]).
range(Start, End, [Start|ER]) :- S2 is Start+1, range(S2, End, ER).

% 1.23 Extract a given number of randomly selected elements from a list.  The selected items shall be put into a result list
% rnd_select(List, Number, ResultList).=
rnd_index(List, Index) :- length(List, LL), End is LL + 1, random(1, End, Index).

rnd_select(List, 1, [Element]) :- rnd_index(List, Index), remove_at(Element, List, Index, _).
rnd_select(List, N, [Element|TR]) :- N > 1, rnd_index(List, Index), remove_at(Element, List, Index, Remain), N2 is N-1, rnd_select(Remain, N2, TR).

% 1.24 Lotto: Draw N different random numbers from the list 1 to M
% lotto(N, M, ResultList).
% TODO sanity checks on numbers
lotto(N, M, Lotto) :- range(1, M, Numbers), rnd_select(Numbers, N, Lotto).

% 1.25 Generate a random permutation of the elements of a list
% rnd_permute(List, Permutation)
rnd_permute(List, Permutation) :- length(List, LL), rnd_select(List, LL, Permutation).

% 1.26 Generate the combinations of K distinct objects chosen from the N elements of a list
% combination(Number, List, ResultList).
% TODO

% 1.27 Group the elements of a set into disjoint subsets
% TODO

% 1.28 Sort a list of lists according to the length of sublists
% TODO

% 4.01 Check whether a given term represents a binary tree
% istree(TreeCandidate).
istree(nil).
istree(t(_, Left, Right)) :- istree(Left), istree(Right).

% 4.02 Construct balanced binary tree
% cbal_tree(Size, Tree).
is_odd(Number) :- 1 is Number mod 2.

cbal_tree(1, t(x, nil, nil)) :- !.
cbal_tree(2, t(x, t(x, nil, nil), nil)).
cbal_tree(2, t(x, nil, t(x, nil, nil))).
cbal_tree(Size, t(x, LeftTree, RightTree)) :- Size > 2, is_odd(Size), !, SubSize is div((Size - 1), 2), cbal_tree(SubSize, LeftTree), cbal_tree(SubSize, RightTree).
cbal_tree(Size, t(x, LeftTree, RightTree)) :- Size > 2, SmallSubSize is div((Size - 1), 2), LargeSubSize is SmallSubSize + 1, cbal_tree(SmallSubSize, LeftTree), cbal_tree(LargeSubSize, RightTree).
cbal_tree(Size, t(x, LeftTree, RightTree)) :- Size > 2, SmallSubSize is div((Size - 1), 2), LargeSubSize is SmallSubSize + 1, cbal_tree(LargeSubSize, LeftTree), cbal_tree(SmallSubSize, RightTree).

% 4.03 Symmetric binary trees
% symmetric(Tree).
mirror(nil, nil).
mirror(t(_, LT1, RT1), t(_, LT2, RT2)) :- mirror(LT1, RT2), mirror(RT1, LT2).

symmetric(t(_, LeftTree, RightTree)) :- mirror(LeftTree, RightTree).
