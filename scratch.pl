% Conditionally set Id using reif's if_
{ if_((R #< 13',' G #< 14',' B #< 15),
          number_chars(Id,Id0),
          Id #= 0
          )
       }

% Ended up not needing this.
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