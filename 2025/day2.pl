:- use_module(library(pio)).
:- use_module(library(dcgs)).
:- use_module(library(charsio)).
:- use_module('../utils.pl').

in_domain(Bases, Var) :-
	make_domain(Bases, Term),
	Var in Term.

make_domain([To-From], To..From).
make_domain([To-From|T], To..From'\\/'TDomain) :-
  make_domain(T, TDomain).

tuple(X-Y) --> integer(X), "-", integer(Y).

row([H|T]) -->
    tuple(H),
    ",",
    row(T).

row([H]) -->
  tuple(H),
  eol.

invalid_id(N):-
  number_chars(N,S),
  same_halves(S).

same_halves(S) :-
  append(Half, Half, S),!.


solveA(N) :-
 phrase_from_file(row(Row), 'day2_input.txt'),
 make_domain(Row, Domain), 
 findall(Z, (Z in Domain, label([Z]), invalid_id(Z)), All),
 sum_list(All, N).