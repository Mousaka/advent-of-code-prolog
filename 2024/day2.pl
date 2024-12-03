:- use_module(library(dcgs)).
:- use_module(library(ordsets)).
:- use_module(library(pio)).
:- use_module(library(charsio)).
:- use_module(library(debug)).
:- use_module('../utils.pl').


safety_lines(0)          --> call(eos), !.
safety_lines(N) --> 
  row(Ns),
  {(safe_line(Ns) -> N #= N0 + 1 ; N #= N0 )  },
  safety_lines(N0).


% DCGs for parsing the file
row([I]) -->
    integer(I),
    ws,
    eol.

row([I | Rest]) -->
    integer(I),
    non_zero_ws,
    row(Rest).

rows([Row | Rest]) -->
    row(Row),
    rows(Rest).

rows([]) -->
    blanks,
    eos.

safe_line_([_], _):- !.
safe_line_([A,B|Ls], C) :-
  zcompare(C,A,B),
  C \= (=),
  D #= abs(A - B),
  D #=< 3,
  safe_line_([B|Ls], C).

safe_line(Ls) :-
  safe_line_(Ls,_).



solveA(Sum) :-
  phrase_from_file(safety_lines(Sum), 'day2_input.txt').
%  phrase_from_file(safety_lines(Sum), 'day2_example.txt').

%% ----------- B ----------

safe_lineB(Ls) :-
  safe_line(Ls).
safe_lineB(Ls) :-
  select(_, Ls, OneRemoved),
  safe_line(OneRemoved).

safety_linesB(0)          --> call(eos), !.
safety_linesB(N) --> 
   row(Ns),
   {(safe_lineB(Ns) -> N #= N0 + 1 ; N #= N0 )  },
   safety_linesB(N0).


solveB(Sum) :-
  phrase_from_file(safety_linesB(Sum), 'day2_input.txt').
  % phrase_from_file(safety_linesB(Sum), 'day2_example.txt').