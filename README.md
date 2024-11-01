Novelty Grinder
===============

Novelty Grinder is a chess tool that identifies strong surprise moves, or moves likely to catch an opponent off guard, by following these steps:

Analyzing Candidate Moves: The tool uses a chess engine to analyze a position and suggest several strong moves, initially based on a specified node count (using --nodes).

Filtering Out Common Moves: Moves already played in the game (PGN) and popular moves from the Lichess master database are removed from the candidate list, leaving less common options.

Ensuring Move Quality: The remaining candidates are analyzed again for a minimum quality (set by --double-check-nodes) to ensure they’re reliable surprise moves.

Outputting Results: The final list of strong but unexpected moves is saved in a new PGN file with annotations.

In short, Novelty Grinder refines candidate moves into surprising, high-quality options to add a strategic edge in games.

Installation
------------

Prerequisites
- Python 3.8+ (or possibly a newer version is required)
- Lc0, version 0.31+ is suggested for contempt
- [Nibbler](https://github.com/rooklift/nibbler/). Optional, but
  highly recommended for Lc0 configuration.

Configuration
- Run `setup-python-venv.sh`. This creates a Python virtual
  environment and fetches dependencies


Running
-------

Run `./novelty-grinder` without parameters for the built-in help.

For example:

    ./novelty-grinder --engine=lc0 --nodes=100000 --eval-threshold=100 --arrows --first-move=4 --book-cutoff=40 input-games.pgn | tee annotated-games.pgn

This command uses engine `lc0` to analyze the game:
- The full path in engines.json can be omitted.
- Initial search is 100 kN per move, starting from move 4.
- Moves less than 4% from the top move are considered *initial candidate*
  moves. That's 1% plus the default 3% initial margin.
- Default popularity cutoff is used. That is, moves with at most 5%
  popularity are considered for surprises.
- Unpopular alternative moves and novelties are analyzed further until
  they have at least 10 kN each. Suggested moves are those that
  are less than 1% from the top move.
- Arrows are added in the PGN annotation for visualization. Red arrow
  = novelty; green arrow = unpopular engine move
- Analysis is stopped when less than 40 games are in the database.


Tips
----

For proper surprises, configure Lc0 contempt. Contempt can find sharp
moves that may not be objectively the best, but instead, they provide
the best winning chances. A bit of experimentation with Nibbler is
recommended to find suitable settings. See
https://lczero.org/blog/2024/03/gm-matthew-sadler-on-wdl-contempt/ for
further information.


Analysis examples
-----------------
- [2024 FIDE Candidates (Open section)](https://github.com/skiminki/novelty-grinder/releases/tag/v0.1-candidates)
