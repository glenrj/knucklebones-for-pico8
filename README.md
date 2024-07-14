# Knucklebones for PICO-8
## Description
This is a backup of a game developed for the [PICO-8 Fantasy Console](https://www.lexaloffle.com/pico-8.php). It is currently a work-in-progress.
## Knucklebones
### Rules
Each player has a 3x3 grid, organized into three columns. They take turns rolling a die and placing it into an open spot in their grid. If there is a matching die in their opponenet's matching column, the opponent must remove all matching dice in that column. When one player's grid is full, the game is over and the player with the highest score is the winner.
### Scoring
Each column is calculated separately, then added to the player's total score. If there are matching dice in the column, their values are added together and multiplied by the amount of matching dice.
### PICO-8 Controls
⬅️⬆️➡️⬇️ Move cursor
❎ Select
## Goals
- [x] MVP
- [ ] Add SFX
- [ ] Add Music
- [ ] Select column instead of grid spot
- [ ] Stop player from selecting full column
- [ ] Add rules to game
- [ ] Redo main layout
## Stretch Goals
- [ ] Fake08 compatibility
- [ ] local High Score leaderboard
- [ ] change dice colour for multiples
- [ ] Pass and Play