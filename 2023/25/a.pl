:- use_module('../../utils.pl').
:- use_module(library(ordsets)).
:- use_module(library(dif)).
jqt-[rhn,xhk,nvd].
xhk-[hfx].

k_n(N, Adjs) :-
        length(Nodes, N),
        Nodes ins 1..N,
        all_distinct(Nodes),
        once(label(Nodes)),
        maplist(adjs(Nodes), Nodes, Adjs).

adjs(Nodes, Node, Node-As) :-
        tfilter(dif(Node), Nodes, As).


warshall(Adjs, Nodes0, Nodes) :-
        phrase(reachables(Nodes0, Adjs), Nodes1, Nodes0),
        sort(Nodes1, Nodes2),
        if_(Nodes2 = Nodes0,
            Nodes = Nodes2,
            warshall(Adjs, Nodes2, Nodes)).

reachables([], _) --> [].
reachables([Node|Nodes], Adjs) -->
        { member(Node-Rs, Adjs) },
        Rs,
        reachables(Nodes, Adjs).


node_number(Node, N):-
  atom_codes(Node, [A,B,C]),
  #N #= #A * 1000000 + #B * 1000 + #C.

sort_connected(Ls0, Ls):-
  maplist(node_number, Ls0, [X|Ls1]),
  sort(Ls1,Ls2),
  maplist(\ A^B^(B = [X,A]) , Ls2, Ls ).


state(S0,S), [S] --> [S0].

two_groups --> [A,B], two_groups().
two_groups --> 


  %%%%%%%%% Testdata
  t([[jqt,rhn,xhk,nvd],[rsh,frs,pzl,lsr],[xhk,hfx],[cmg,qnr,nvd,lhk,bvb],[rhn,xhk,bvb,hfx],[bvb,xhk,hfx],[pzl,lsr,hfx,nvd],[qnr,nvd],[ntq,jqt,hfx,bvb,xhk],[nvd,lhk],[lsr,lhk],[rzs,qnr,cmg,lsr,rsh],[frs,qnr,lhk,lsr]]).
  tt(B):-
    t(X), maplist(sort_connected, X,D),
    append(D,B).



  asd(Ps) :-
    t(D),
    tuples_in(Ps, D).

  