:- use_module('../utils.pl').

diff_numbers([A,B|Ls],[Diff|Rest]):-
  Diff #= B - A,
  length([B|Ls],L),
  if_(L #< 2, Rest = [], diff_numbers([B|Ls], Rest) ).

all_zero_sum(X,Sum0,Sum):-
   if_((X #= 0 ',' Sum0 #= 0), Sum #= 0, Sum #= 1). 

diff_until_zeros(Ls, [Diff|Rest]):-
  diff_numbers(Ls, Diff),

  % All diff values should be ascending or descending 
  % maplist(\ X^Y^(Y#=abs(X)), Diff, DiffAbs),
  % chain(#=<, Diff), 
  % asc_or_desc(Diff),
  % ----------------
  
  foldl(all_zero_sum,Diff,0,Sum),
  if_(Sum #= 0, Rest = [], diff_until_zeros(Diff, Rest)).

oasis_number(Ls, N):-
  reverse(Ls, LsRev),
  reverse([N|LsRev], LsN),
  diff_until_zeros(LsN,_).


solve(N):-
  phrase_from_file(lines(Lines), 'input.txt'),
  once(maplist(\X^Y^phrase(seqDelimited(' ', znumber, Y), X),
            Lines,
            Ls)),
  maplist(oasis_number, Ls, Os),
  sum_list(Os,N).

asc_or_desc(Ls):-
  a_or_d(Ls,_).

a_or_d(Ls, R):-
  length(Ls, L),

  if_(L #< 2,
    R #= 1,
    (
      [A,B|Rest] = Ls,
      if_(
        A #= B,
        a_or_d([B|Rest],R),
        if_(
          A #< B,
          (chain(#=<, [A,B|Rest]), R #= 1),
          (chain(#>=, [A,B|Rest]), R #= 1)
        )
      )
    )
  ).

%%%%%%%%%%% Testing
i([0,3,6,9,12,15]).
j([1, 3, 6,10, 15 ,21]).
k([10, 13, 16, 21, 30, 45]).
l([7,1,-5, 0, 28, 99, 260, 616, 1373, 2893, 5761, 10864, 19482, 33391, 54978, 87368, 134563, 201593, 294679, 421408, 590920]).
m([10,9,2,-15,-46,-95,-166,-263,-390,-551,-750,-991,-1278,-1615,-2006,-2455,-2966,-3543,-4190,-4911,-5710]).
n([-1,-2,-2,15,92,314,825,1846,3693,6794,11704,19117,29874,44966,65531,92844,128299,173382,229634,298603,381784]).

solve1(S):-
  i(I),
  j(J),
  k(K),
  l(L),
  m(M),
  n(N),
  maplist(oasis_number, [I,J,K,L,M,N], Os),
  sum_list(Os, S).