:- use_module(library(pio)).
:- use_module(library(dcgs)).
:- use_module(library(charsio)).
:- use_module('../utils.pl').

apply_op(Op, A, B, Result) :-
    Expr =.. [Op, A, B],
    Result #= Expr.

l_r(+) --> "R", !.
l_r(-) --> "L".

inner_row(Pos, NextPos, Zeroes) -->
    l_r(Op),
    integer(I),
    { apply_op(Op, 0, I, N),
      NextPos #=  (Pos + N) mod 100,
      if_(NextPos #= 0,
          Zeroes #= 1,
          Zeroes #= 0) }.


row(Pos, Zeroes) -->
    inner_row(Pos, NextPos, Zeroes1),
    {Zeroes #= Zeroes1 + Zeroes0 },
    non_zero_ws,
    row(NextPos, Zeroes0).

row(Pos, Zeroes) -->
  inner_row(Pos, _, Zeroes),
  ws, eol.

solveA(Z) :-
 phrase_from_file(row(50,Z), 'day1_input.txt').