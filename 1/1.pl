:- use_module(library(dcgs)).
:- use_module(library(pio)).
:- use_module(library(charsio)).


digit(0)-->"0".
digit(1)-->"1".
digit(2)-->"2".
digit(3)-->"3".
digit(4)-->"4".
digit(5)-->"5".
digit(6)-->"6".
digit(7)-->"7".
digit(8)-->"8".
digit(9)-->"9".

nat(N)   --> digit(D), nat(D,N).
nat(N,N) --> [].
nat(A,N) --> digit(D), { A1 is A*10 + D }, nat(A1,N).

letter --> [A], { char_type(A, alpha) }.


keep_first_number(N), [H] --> first_number(N), { number_chars(N, [H]) }.
keep_first_number(N) --> digit(N). 

first_number(N) --> digit(N), ... .
first_number(N) --> letter, first_number(N).


last_number(N) --> ..., digit(N).
last_number(N) --> last_number(N),letter.


sum_first_and_last(Sum) --> keep_first_number(N1), last_number(N2), { Sum is N1 + N2 }.

sum_lines([], 0).
sum_lines([Line|Lines], N) :-
  phrase(sum_first_and_last(N1), Line),
  sum_lines(Lines, N0),
  N #= N0 + N1.


solve(Sum) :-
 phrase_from_file(lines(Ls), '1.txt'), sum_lines(Ls, Sum).


% ["1abc2", "pqr3stu8vwx", "a1b2c3d4e5f", "treb7uchet"]


eos([], []).

line([]) -->
  ( "\n" | call(eos) ).
line([C|Cs]) --> [C], line(Cs).

lines([]) --> call(eos), !.
lines([L|Ls]) --> line(L), lines(Ls).
