:- use_module(library(dcgs)).
:- use_module(library(pio)).
:- use_module(library(charsio)).
:- use_module('../../utils.pl').
  
color(blue) --> "blue".
color(red) --> "red".
color(green) --> "green".

color_count((N,0,0)) --> number(N), " ", color(blue).
color_count((0,N,0)) --> number(N), " ", color(red).
color_count((0,0,N)) --> number(N), " ", color(green).

cube_delimiter --> ", ".
cube_delimiter, ";" --> ";".

% Took me such a long time before I noted that the operator ','/3 is suppose to have '' around it. :(
parse_set((B,R,G), Invalid) -->  
  parse_set((B,R,G)),
  { if_((R #< 13',' G #< 14',' B #< 15),
        Invalid #= 0,
        Invalid #= 1
       )
  }. 

parse_set(Cube) --> color_count(Cube).
parse_set((B,R,G)) --> 
  color_count((B1,R1,G1)),
  cube_delimiter,
  parse_set((B0,R0,G0)),
  { B #= B1 + B0,
    R #= R1 + R0,
    G #= G1 + G0 }.

parse_sets(Invalid) --> parse_set(_,Invalid1), "; ", parse_sets(Invalid0),
                        { Invalid #= Invalid0 + Invalid1}.
     
parse_sets(Invalid) --> parse_set(_,Invalid). 

game_line(Id) --> "Game ", number(Id0), ": ", parse_sets(Invalid),
                  {if_(dif(Invalid, 0),
                       Id #= 0,
                       Id #= Id0 
                      )
                  }.

game_id_count([], 0).
game_id_count([Line|Lines], N) :-
  phrase(game_line(N1), Line),
  game_id_count(Lines, N0),
  N #= N0 + N1.

solve(Sum) :-
 phrase_from_file(lines(Ls), 'input.txt'), game_id_count(Ls, Sum).

solve_ex(Sum) :-
 phrase_from_file(lines(Ls), 'example.txt'), game_id_count(Ls, Sum).


