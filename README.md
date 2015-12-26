Boggle Solver
=============

Find the best words for a given [Boggle](https://en.wikipedia.org/wiki/Boggle) board.

## Basic Usage

You will need a wordlist. One comes pre-installed on Macs and many Linux distributions in `/usr/share/dict/words`.

The format of the wordlist is simply a text file with one word per line.

Enter your puzzle into a file as the ascii representation of the board. For example:

`examples/puzzle.txt`:
```
RHRS
YPCS
WNSN
TEGO
```

To run the solver, just pipe the ascii representation of the puzzle into stdin:

```
./bin/solver /path/to/dict < examples/puzzle.txt
```

## Disclaimer

*Boggle is a trademark of Hasbro. This project has no affiliation with Hasbro.*
