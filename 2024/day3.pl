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
    

state(S), [S] --> [S].
state(S0, S), [S] --> [S0].

do(0) --> ( call(eos) ), !.
do(N) --> "don't()", dont(N).                     %'
do(N) --> next_mul(N0), {N #= N0 + N1 },do(N1).
do(N) --> [_], dont(N).

dont(0) --> ( call(eos) ), !.
dont(N) --> "do()", do(N).
dont(N) --> [_], dont(N).