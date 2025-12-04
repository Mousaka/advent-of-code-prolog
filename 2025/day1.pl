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


 %%%% PART 2


extraPass(Pos,V,N):-
  if_( Pos #= 0
     , N #= 0
     , if_((99 #< V; V #< 1 )
          , N #= 1
          , N #=0)).
  

nextPos(Pos, Rot, NextP, Passes) :-
  NextP #=  (Pos + Rot) mod 100,
  Passes #= ExtraP + (abs(Rot) // 100),
  Foo #= Pos + (Rot rem 100),
  extraPass(Pos,Foo, ExtraP).


inner_row2(Pos, NextPos, Zeroes) -->
    l_r(Op),
    integer(I),
    { apply_op(Op, 0, I, Rot),
      nextPos(Pos, Rot, NextPos, Zeroes)
    }.


row2(Pos, Zeroes) -->
    inner_row2(Pos, NextPos, Zeroes1),
    {Zeroes #= Zeroes1 + Zeroes0 },
    non_zero_ws,
    row2(NextPos, Zeroes0).

row2(Pos, Zeroes) -->
  inner_row2(Pos, _, Zeroes),
  ws, eol.

solveB(Z) :-
 phrase_from_file(row2(50,Z), 'day1_input.txt').