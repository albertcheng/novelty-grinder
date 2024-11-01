Novelty Grinder
===============

The Novelty Grinder is a tool for chess players to find “surprise moves,” or moves that the opponent might not expect but are still strong enough to be effective.

Position Analysis with a Chess Engine:

Imagine a chess engine as a really powerful calculator that suggests the best possible moves. When analyzing a position, the engine looks at all the possible moves and picks a handful of the best options based on how strong they are. This list of moves is our "candidate moves" – moves that might have the potential to surprise the opponent.
To get these candidate moves, the engine needs to "think" about the position for a while, which is called "searching nodes." The more nodes it searches, the more reliable the move recommendations are. You can set the initial number of nodes it should search using the --nodes command.
Filtering Out Obvious Moves:

Chess games are recorded in a format called PGN (Portable Game Notation), which logs every move played in a game. If you have a list of moves already played in games, you don’t want to consider these for surprise moves since they’re well known.
So, any moves already played in the input PGN file are removed from the list of candidate moves.
Removing Popular Moves:

To further make sure we’re left with “surprise moves,” the tool checks the Lichess master database. This is a huge database of popular moves played by strong players. If a candidate move is one of these popular moves, it’s removed, too, because if it’s well-known, it’s not much of a surprise!
Checking Quality of Candidate Moves:

Now, we’re left with a list of less common candidate moves, which could be potential surprises. But we still need to make sure these moves are strong enough to be playable.
So, each candidate move goes through a more detailed analysis. To make sure the analysis is reliable, each move is examined by the engine until it has been “thought about” (or checked) at least a certain number of nodes. You can set this minimum number of nodes with the --double-check-nodes option. By default, it’s set to 10% of the nodes searched in the first step.
Selecting Final Surprise Moves:

After this second analysis, the moves with scores above a certain threshold are kept. These are the final surprise moves – moves that are strong but not likely to be anticipated by the opponent.
Outputting the Surprise Moves with Annotations:

Finally, Novelty Grinder creates a new PGN file (a file format for storing chess games) that includes these surprise moves along with annotations, so you can see which moves might add an unexpected twist to your game.
In short, Novelty Grinder filters out common moves, refines potential surprise options with the chess engine, and then outputs these unique, strong moves as suggestions for you to try in your games. This tool helps bring an extra element of surprise to your strategy, making it harder for opponents to predict your next move!

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
