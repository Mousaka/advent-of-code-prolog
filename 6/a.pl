% Example
% records([(7,9), (15,40), (30,200)]).
% Part 1
%records([(48, 261),(93, 1192),(84,1019),(66,1063)]).

% Part 2
records([(71530,940200)]).

beats_record(B, (T, D)) :-
  B #>= 0,
  TravelT #= T - B,
  TravelT * B #> D.

product_of_list([], 1).
product_of_list([H|T], Product) :-
   product_of_list(T, Rest),
   Product #= H * Rest.

button_times(All,L):-
  records(Rs),
  member((T,D), Rs),
  findall(B,(beats_record(B,(T,D)), label([B])), All),
  length(All,L).

solve(S):-
  findall(L, button_times(_,L), All),
  product_of_list(All,S).
 
