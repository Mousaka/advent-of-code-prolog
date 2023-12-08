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

% An alternative way to solve the problem.
% Received some feedback that fd_size is relying on implementation
% choices in the constraint solver and could be unstable to use over time.
% Got a tip that label([Bottom]) can be used to find the greatest value
% in the domain in a fast reliable way.
% Read more https://github.com/mthom/scryer-prolog/discussions/2213#discussioncomment-7794704
alt_solve(S):-
  input(R),
  once((beats_record(Upper, R), labeling([down],[Upper]))),
  once((beats_record(Bottom, R), label([Bottom]))),
  S #= Upper - Bottom + 1.
 
