:- use_module(library(dcgs)).
:- use_module(library(pio)).
:- use_module(library(charsio)).


digit('0') -->"0".
digit('1') -->"1".
digit('2') -->"2".
digit('3') -->"3".
digit('4') -->"4".
digit('5') -->"5".
digit('6') -->"6".
digit('7') -->"7".
digit('8') -->"8".
digit('9') -->"9".

% Comment these for part 1
digit('1') -->"one".
digit('2') -->"two".
digit('3') -->"three".
digit('4') -->"four".
digit('5') -->"five".
digit('6') -->"six".
digit('7') -->"seven".
digit('8') -->"eight".
digit('9') -->"nine".

letter --> [A], { char_type(A, alpha) }.

keep_first_digit(N), [N] --> first_digit(N).
keep_first_digit(N) --> digit(N). 

first_digit(N) --> digit(N), ... .
first_digit(N) --> letter, first_digit(N).

last_digit(N) --> ..., digit(N).
last_digit(N) --> last_digit(N),letter.

concat_first_and_last_digit(N) --> keep_first_digit(N1), last_digit(N2), {number_chars(N, [N1,N2])}.

sum_lines([], 0).
sum_lines([Line|Lines], N) :-
  phrase(concat_first_and_last_digit(N1), Line),
  sum_lines(Lines, N0),
  N #= N0 + N1.


solve(Sum) :-
 phrase_from_file(lines(Ls), '1.txt'), sum_lines(Ls, Sum).


% Reading lines
 
eos([], []).

line([]) -->
  ( "\n" | call(eos) ).
line([C|Cs]) --> [C], line(Cs).

lines([]) --> call(eos), !.
lines([L|Ls]) --> line(L), lines(Ls).
