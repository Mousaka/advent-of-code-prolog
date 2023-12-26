:- use_module('../utils.pl').

zero_or_one_sum(X,Sum0,Sum):-
   if_((X #= 0 ',' Sum0 #= 0), Sum #= 0, Sum #= 1). 


diff_numbers([A,B|Ls],[Diff|Rest]):-
  Diff #= B - A,
  length([B|Ls],L),
  if_(L #< 2, Rest = [], diff_numbers([B|Ls], Rest) ).


diff_until_zeros(Ls, [Diff|Rest]):-
  $diff_numbers(Ls, Diff),
  foldl(zero_or_one_sum,Diff,0,Sum), % Sum binds to 0 if all Diffs are 0, otherwise 1.
  if_(Sum #= 0, Rest = [], diff_until_zeros(Diff, Rest)).


oasis_number(Ls, N):-
  reverse(Ls, LsRev),
  reverse([N|LsRev], LsN),
  diff_until_zeros(LsN,_).


oasis_number_p2(Ls, N):-
  diff_until_zeros([N|Ls],_).


solve(N,PartSolver):-
  phrase_from_file(lines(Lines), 'input.txt'),
  once(maplist(\X^Y^phrase(seqDelimited(' ', znumber, Y), X),
            Lines,
            Ls)),
  maplist(PartSolver, Ls, Os),
  sum_list(Os,N).


part1(S):-
  solve(S,oasis_number).


part2(S):-
  solve(S,oasis_number_p2). 