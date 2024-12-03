:- use_module(library(dcgs)).
:- use_module(library(ordsets)).
:- use_module(library(pio)).
:- use_module(library(charsio)).
:- use_module(library(debug)).
:- use_module('../utils.pl').


mul(N) --> "mul(",number(A),",",number(B),")", { N #= A * B }.

next_mul(N) --> [_], mul(N).
next_mul(N) --> mul(N).
next_mul(N) --> [_], next_mul(N).

all_muls(0) --> ( call(eos) ), !.
all_muls(N) --> next_mul(N1), { N #= N0 + N1 }, all_muls(N0).
all_muls(N) --> [_], all_muls(N).

solveA(N):-
    phrase_from_file(all_muls(N),'day3_input.txt').