:- use_module(library(dcgs)).
:- use_module(library(pio)).
:- use_module(library(charsio)).
:- use_module(library(ordsets)).
:- use_module('../../utils.pl').

spacing --> " ".
spacing --> "  ".
spacing --> "   ".

winning_numbers([W1,W2,W3,W4,W5,W6,W7,W8,W9,W10]) --> 
                            spacing, number(W1), spacing, number(W2), spacing, number(W3), spacing,
                            number(W4), spacing, number(W5), spacing, number(W6), spacing, number(W7), spacing,
                            number(W8), spacing, number(W9), spacing, number(W10), spacing.

numbers([N1,N2,N3,N4,N5,N6,N7,N8,N9,N10,N11,N12,N13,N14,N15,N16,N17,N18,N19,N20,N21,N22,N23,N24,N25]) -->
          spacing, number(N1), spacing, number(N2), spacing, number(N3), 
          spacing,
          number(N4), spacing, number(N5), spacing, number(N6), spacing,
          number(N7), spacing, number(N8),spacing, number(N9), spacing,
          number(N10), spacing, number(N11), spacing,
          number(N12), spacing, number(N13), spacing, number(N14), spacing,
          number(N15), spacing, number(N16), spacing, number(N17), spacing, number(N18), spacing,
          number(N19), spacing, number(N20), spacing, number(N21), spacing,
          number(N22), spacing,number(N23), spacing,number(N24), spacing,number(N25).

card_line(Ws, Ns) --> "Card",spacing, number(_), ":", winning_numbers(Ws),
                  "|", numbers(Ns).

score_line(Score, Ws,Ns) :-
   list_to_ord_set(Ws, Wset),
   list_to_ord_set(Ns, Nset),
   ord_intersection(Wset,Nset,Wins),
   score_wins(Score, Wins).

score_wins(0, []).
score_wins(Score, Wins) :-
   length(Wins,L),
   L > 0,
   Score #= 2^(L-1).

score_games([], 0).
score_games([Line|Lines], Score) :-
  phrase(card_line(Ws,Ns), Line),
  score_line(Score1,Ws,Ns),
  score_games(Lines, Score0),
  Score #= Score0 + Score1.

solve(Sum) :-
 phrase_from_file(lines(Ls), 'input.txt'), score_games(Ls, Sum).

% Example actually broken because non generalised solution
solve_ex(Sum) :-
 phrase_from_file(lines(Ls), 'example.txt'), score_games(Ls, Sum).


