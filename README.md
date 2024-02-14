# Battle Simulator

This script simulates a battle between a player and a Prismarine Colossus, a huge prismarine statue that measures over 20 meters in height.

## Dependencies

The script requires the following modules:
- `utils`: Contains utility functions such as enabling UTF-8 in the terminal, printing headers, and introducing the monster.
- `player.player`: Defines the player's attributes and actions.
- `player.actions`: Contains the actions that the player can perform.
- `colossus.colossus`: Defines the attributes of the Prismarine Colossus.
- `colossus.actions`: Contains the actions that the Prismarine Colossus can perform.

## Gameplay

The game starts by introducing the Prismarine Colossus to the player. The player and the Colossus then take turns performing actions until one of them runs out of health.

The player is presented with a list of valid actions they can perform each turn. If the player chooses an invalid action, they miss their turn.

The Colossus performs a random valid action each turn.

## Win/Lose Conditions

The game ends when either the player or the Colossus runs out of health. If the player's health reaches zero, they lose the game. If the Colossus' health reaches zero, the player wins the game.
