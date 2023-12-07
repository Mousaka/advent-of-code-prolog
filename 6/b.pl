% Part 2
% example
example_input((71530,940200)).
% real input
input((48938466,261119210191063)).

beats_record(B, (T, D)) :-
  B #>= 0,
  TravelT #= T - B,
  TravelT * B #> D.

% Can I hide the domain printing somehow?
solve(S):-
  input(R),
  beats_record(B, R), fd_size(B, S).
 
