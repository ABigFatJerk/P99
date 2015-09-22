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

% TODO accumulator version

% 1.04 Find the number of elements in a list
% my_length(Length, List).
my_length(0, []).
my_length(Len, [_|T]) :- my_length(Sublen, T), Len is Sublen+1. 

% TODO accumulator version

% 1.05 Reverse a list
% my_reverse(List, ReversedList)
