:- use_module('../utils.pl').

i([0,3,6,9,12,15]).
j([1, 3, 6,10, 15 ,21]).
k([10, 13, 16, 21, 30, 45]).
l([7,1,-5, 0, 28, 99, 260, 616, 1373, 2893, 5761, 10864, 19482, 33391, 54978, 87368, 134563, 201593, 294679, 421408, 590920]).
m([10,9,2,-15,-46,-95,-166,-263,-390,-551,-750,-991,-1278,-1615,-2006,-2455,-2966,-3543,-4190,-4911,-5710]).


diff_numbers([A,B|Ls],[Diff|Rest]):-
  Diff #= B - A,
  length([B|Ls],L),
  if_(L #< 2, Rest = [], diff_numbers([B|Ls], Rest) ).


diff_until_zeros(Ls, [Diff|Rest]):-
  diff_numbers(Ls, Diff),

  % All diff values should be ascending or descending 
  % maplist(\ X^Y^(Y#=abs(X)), Diff, DiffAbs),
  chain(#=<, Diff), 
  % ----------------
  
  foldl(\ X^Sum0^Sum^(Sum#=X+Sum0),Diff,0,Sum),
  if_(Sum #= 0, Rest = [], diff_until_zeros(Diff, Rest)).

oasis_number(Ls, N):-
  N #> 0,
  reverse(Ls, LsRev),
  reverse([N|LsRev], LsN),
  diff_until_zeros(LsN, _).

solve1(S):-
  i(I),
  j(J),
  k(K),
  maplist(oasis_number, [I,J,K], Os),
  sum_list(Os, S).

solve(Os):-
  phrase_from_file(lines(Lines), 'input.txt'),
  once(maplist(\X^Y^phrase(seqDelimited(' ', znumber, Y), X),
            Lines,
            Ls)),
  maplist(oasis_number, Ls, Os).


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
