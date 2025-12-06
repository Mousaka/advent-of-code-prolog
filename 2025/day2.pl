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
tupleSum(S) --> integer(X), "-", integer(Y), {invalids_in_range(X-Y, S)}.

row(Sum) -->
    tupleSum(S),
    ",",
    row(S0),
    { Sum #= S + S0}.

row(Sum) -->
  tupleSum(Sum),
  eol.

num_digs(X, N):- N in 1..20, 10^(N - 1) #=< X, X #< 10^N, label([N]).

invalid_id(N):-
  number_chars(N,S),
  same_halves(S).

same_halves(S) :-
  append(Half, Half, S),!.

invalids_in_range(T-F, Sum) :-
  findall(I, (I #< F + 1, T - 1 #< I, label([I]), invalid_id(I)), Is), sum_list(Is, Sum).
  


solveA(Sum) :-
 phrase_from_file(row(Sum), 'day2_example.txt').