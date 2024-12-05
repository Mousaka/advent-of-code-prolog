:- use_module(library(dcgs)).
:- use_module(library(ordsets)).
:- use_module(library(pio)).
:- use_module(library(charsio)).
:- use_module(library(debug)).
:- use_module('../utils.pl').



xmas("XMAS").
xmas("SAMX").

xmas_line([X,M,A,S|_]):-
  xmas([X,M,A,S]).
xmas_line([_|T]):-
  xmas_line(T).

xmas_lines([Row|_]):-
  xmas_line(Row).
xmas_lines([_|T]):-
  xmas_lines(T).

xmas_columns(Rows):-
  transpose(Rows,Columns),
  xmas_lines(Columns).


diagonal1([Row|Rows],Index, [H|D0]):-
  Index #< 4,
  nth0(Index, Row, H),
  NextIndex #= Index + 1,
  diagonal1(Rows, NextIndex, D0).
diagonal1(_,4,_).


xmas_diagonal(Rows):-
  xmas_diagonal_on_row(Rows).
xmas_diagonal([_|Rows]):-
  xmas_diagonal(Rows).

xmas_diagonal_on_row([Row|Rows]):-
    diagonal1([Row|Rows], 0, Diagonal1),
    xmas(Diagonal1).
xmas_diagonal_on_row([[_|ShavedRow]|Rows]):-
  maplist(drop1, Rows, ShavedRows),
  xmas_diagonal_on_row([ShavedRow|ShavedRows]). 


drop1([_|T], T).

xmas_board(Rows):-
  xmas_lines(Rows).
xmas_board(Rows):- 
  xmas_columns(Rows).
xmas_board(Rows):-
  xmas_diagonal(Rows).
xmas_board(Rows):-
  maplist(reverse,Rows,ReverseRows),
  xmas_diagonal(ReverseRows).

t(["XXasd"
  ,"SMMsd"
  ,"xAAAd"
  ,"xmMSS"
  ,"xmaXX"]).

solveA(N):-
  phrase_from_file(lines(Ls), 'day4_input.txt'),
  findall(_, xmas_board(Ls),Solutions),
  length(Solutions,N).


%%%%%%%%%%%%%%%%%% Part 2

ms("MM"
  ,"SS").
ms("SM"
  ,"SM").
ms("SS"
  ,"MM").
ms("MS"
  ,"MS").

xmasb(Rows):-
  I__ #= I_ + 1,
  I_ #= I + 1,

  I3 - I1 #= 2,
  I22 #= I1 + 1,

  nth0(I, Rows, Row), nth0(I1, Row, A11), nth0(I3, Row, A13),
  nth0(I_, Rows, Row_), nth0(I22, Row_, 'A'),
  nth0(I__, Rows, Row__), nth0(I1, Row__, A31), nth0(I3, Row__, A33),

  ms([A11,A13]
    ,[A31,A33]).
    
solveB(N):-
  phrase_from_file(lines(Ls), 'day4_input.txt'),
  findall(_, xmasb(Ls),Solutions),
  length(Solutions,N).