extends Node

@onready var message_label = $UI/MessageLabel  # Reference to your Label node



func game_over(won: bool):
	if won:
		message_label.text = "You found the item! You win!"
	else:
		message_label.text = "Time’s up! You lose!"
	get_tree().paused = true  # Pause the game
