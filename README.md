# Crawlers Of The Skeleton Forest
It is a **2d dungeon crawler single player game** consisting of 4 stages. The player must defeat all of the enemy in the stage before advancing to another. After clearing each stage, a chest will generate which may drop one or two potion, the potion may be a healing potion/strength potion/poison potion, where player may interact with these and gain +1 or +2 hearts, or gain +1 damage for the player. The game is composed of Finite State Machine (FSM) and Markov Model.

## Characters
| Image | Character | Health | Damage |
| ----------- | ----------- | ----------- | ----------- |
| <img src = "./README_Assets/player.jpg" height = "100" width = "100"> | Player | 13 | 1 |
| <img src = "./README_Assets/slime.jpg" height = "100" width = "100"> | Slime | 2 | 1 |
| <img src = "./README_Assets/Swordsman.png" height = "150" width = "100"> | Swordsman | 6 | 3 |
| <img src = "./README_Assets/Kram.png" height = "100" width = "100"> | Kram | 6 | 3 |
| <img src = "./README_Assets/skeleton.png" height = "100" width = "100"> | Skeleton | 3 | 2 |
| <img src = "./README_Assets/Lancer.png" height = "100" width = "100"> | Lancer | 7 | 3 |
| <img src = "./README_Assets/Berserker.png" height = "100" width = "90"> | Berserker | 9 | 2 |

## Potion
| Image | Type | Description |
| ----------- | ----------- | ----------- |
| <img src = "./README_Assets/Potion.png" height = "90" width = "90"> | Health Potion | May heal the player +1 or +2 heart/s or may damage the player -1 heart |
| <img src = "./README_Assets/str.png" height = "90" width = "90"> | Strength Potion | May boost player damage by +1 or +2 |

# Here are figures which describes the behavior of the NPC.

<img src = "./README_Assets/Player_State.png" height = "200" width = "300">

> *Finite State Machine of Player*

<img src = "./README_Assets/Enemy_State.png" height = "200" width = "300">

> *Finite State Machine of NPC*

<img src = "./README_Assets/Enemy_Decision.png" height = "200" width = "300">

> *Markov Model for Enemy Decision*

<img src = "./README_Assets/Potion_Generation.png" height = "200" width = "300">

> *Markov Model for Potion Generation*

<img src = "./README_Assets/Type_Potion.png" height = "200" width = "300">

> *Markov Model for Type of Potion*

<img src = "./README_Assets/Potion_Effectiveness.png" height = "200" width = "300">

> *Markov Model for Potion Effectivnes*

<img src = "./README_Assets/Poison_Heal.png" height = "200" width = "300">

> *Markov Model for Poison or Heal of Potion*
