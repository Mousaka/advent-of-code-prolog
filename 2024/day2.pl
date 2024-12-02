:- use_module(library(dcgs)).
:- use_module(library(ordsets)).
:- use_module(library(pio)).
:- use_module(library(charsio)).
:- use_module(library(debug)).
:- use_module('../utils.pl').


safety_lines(0)          --> call(eos), !.
safety_lines(N) --> 
  safety_line(N1),
  {N #= N0 + N1},
  safety_lines(N0).

% safety_line(0)     --> ( "\n" ; call(eos) ), !.
safety_line(1) --> numbers(Ns), { $safe_line(Ns) }, ("\n"; call(eos)).
safety_line(0) --> numbers(Ns), { \safe_line(Ns) },("\n"; call(eos)).

numbers([]) --> ("\n" ; call(eos)).
numbers([N|Ns]) --> number(N), ws, numbers(Ns).

number(X) --> number([], X).
number(X, Z) --> [C], { char_type(C, numeric) }, number([C|X], Z).
number(X, Z) --> { length(X, L), L #> 0, reverse(X, X1), number_chars(Z, X1) }.
znumber(X) --> "-", number(Y), { X #= -Y }; number(X).
a_digit(X) --> [X], {char_type(X, numeric)}.


safe_line_([_], _):- !.
safe_line_([A,B|Ls], C) :-
  zcompare(C,A,B),
  D #= abs(A - B),
  D #=< 2,
  safe_line_([B|Ls], C).

safe_line(Ls) :-
  safe_line_(Ls,_).



solveA(Sum) :-
 phrase_from_file(safety_linez(Sum), 'day2_input.txt').