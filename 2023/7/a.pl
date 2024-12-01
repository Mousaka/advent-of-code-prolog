


:- use_module('../../utils.pl').


card_value('2',2).
card_value('3',3).
card_value('4',4).
card_value('5',5).
card_value('6',6).
card_value('7',7).
card_value('8',8).
card_value('9',9).
card_value('T',10).
card_value('J',11).
card_value('Q',12).
card_value('K',13).
card_value('A',14).

hand_val(Ls, 1) :-
  all_distinct(Ls).
hand_val(Ls, 2) :-
  

hand_number(Hand, HandNSorted):-
  maplist(card_value, Hand, HandN),
  bubblesort(HandN, HandNSorted).

hand_bid(HandSorted,B) --> seq(H), " ", number(B).


bid_value([],0).
bid_value([Line|Lines], S):-
  phrase(hand_bid((H,B)), Line),
  S #= 0.


solve_ex(V):-
  phrase_from_file(lines(Ls), 'example.txt'), bid_value(V,Ls).