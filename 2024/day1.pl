:- use_module(library(dcgs)).
:- use_module(library(ordsets)).
:- use_module(library(pio)).
:- use_module(library(charsio)).
:- use_module(library(ordsets)).
:- use_module('../utils.pl').

spacing --> "   ".

l([A,B]) --> number(A), spacing, number(B).

distance(A,B,C) :-
  C #= abs(A - B).

integers_ascending(Is0, Is) :-
        all_distinct(Is0),
        ascending(Is),
        permutation(Is0, Is).

innerHelper([L|Ls], [Row|Rows]) :-
  phrase(l(Row), L),
  innerHelper(Ls,Rows).
innerHelper([], []).

inner(Ls, Res2) :-
  innerHelper(Ls, Res),
  transpose(Res,Res1),
  [C1, C2] = Res1,
  mergesort(C1, C1Sorted),
  mergesort(C2, C2Sorted),
  maplist(distance, C1Sorted,C2Sorted, Distance),
  sum_list(Distance, Res2).


  
solve(Sum) :-
 phrase_from_file(lines(Ls), 'day1_input.txt'), inner(Ls, Sum).