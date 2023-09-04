# polecalc

A new Flutter project.

## Getting Started

Made in a couple hours for demo purposes, developed on the web platform issues so far:
- Prints FP no's not fractional numbers
- More foolproofing
- Can't detect Keypresses
- Add more functions like trigo.
- Size buttons properly, flutter has a lot of ways to kinda influence the size of something, need to find an idiomatic way to do it.

Uses RPN (Reverse Polish Notation) or infix notation where the operation is followed by its arguments, eg:
```
1 + (2 / 3)

in infix

+ 1 / 2 3
```

To end one argument and move to the next one, use `SPC`