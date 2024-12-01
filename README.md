# advent-of-code-2023-forward
Advent of code solutions for 2023

## How to run Prolog programs
- Install [Scryer Prolog](https://github.com/mthom/scryer-prolog#installing-scryer-prolog)
- Add this to `~/.scryerrc` which opens some libraries by default (this is a bit buggy)
  - ```
    :- use_module(library(clpz)).
    :- use_module(library(lists)).
    :- use_module(library(dcgs)).
    :- use_module(library(reif)).
    ```
- `scryer-prolog 1/1.pl` starts a REPL with day 1 solution file.
- Sometimes Scryer fails to load default modules from `.scyerrc` and then you need to write `consult('1/1.pl')` which will load the solution file from within the REPL.
- In the REPL write `solve(S).` to get the solution.
