:- use_module(library(dcgs)).
:- use_module(library(ordsets)).
:- use_module(library(pio)).
:- use_module(library(charsio)).
:- use_module(library(debug)).
:- use_module('../utils.pl').

step(Rows, X-Y, Step) :-
  nth1(Y, Rows, Row),
  nth1(X, Row, Step).

guard_start_pos(Rows, X-Y-up):-
  step(Rows, X-Y, _).


xStep(up, 0).
xStep(down, 0).
xStep(left, -1).
xStep(right, 1).
yStep(up, -1).
yStep(down, 1).
yStep(left, 0).
yStep(right, 0).

turn(up,right,'↱').
turn(right,down, '↴').
turn(down,left, '↲').
turn(left,up, '☝︎').

walkable('.').
wall('#').

in_bounds(W,H,X,Y):-
  X #>= 0,
  X #=< W,
  Y #>= 0,
  Y #=< H.

step_forward(Rows,X-Y-D,X1-Y1, Step):-
  xStep(D, Xd),
  yStep(D, Yd),
  X1 #= X + Xd,
  Y1 #= Y + Yd,
  step(Rows,X1-Y1, Step).

g_n_move_(Rows, Coords-D,  N) :-
  \+ step_forward(Rows,Coords-D, _, _),
  N #= 1.
g_n_move_(Rows, Coords-D,  N) :-
  $step_forward(Rows,Coords-D, Coords1, Step),
  walkable(Step),
  N #= N0 + 1,
  g_n_move_(Rows,Coords1-D, N0).
g_n_move_(Rows, Coords-D,  N) :-
  $step_forward(Rows,Coords-D, _,Step_),
  \+ walkable(Step_),
  turn(D,D1,_),
  g_n_move_(Rows,Coords-D1, N).


  
g_n_move(Rows,Coords-D, N):-
  g_n_move_(Rows, Coords-D, N). 
% n(Rows, Coord, S0, Next) :- g_n_move_(Rows, Coord, Next, _).
% n_list(Rows,Ls, S) :- foldl(n(Rows), Ls, 0, S).



path(Rows, N):-
  guard_start_pos(Rows, X-Y-Direction),
  g_n_move(Rows, X-Y-Direction, N).

solveA(S):-
  % phrase_from_file(lines(Ls), 'day6_input.txt'),path(Ls, S).
  phrase_from_file(lines(Ls), 'day6_example.txt'),path(Ls, S).