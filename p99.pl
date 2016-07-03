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

% TODO difference list version

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

