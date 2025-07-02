extends Area2D

func _ready():
	# Connect the signal for when something enters the collectible's area
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.name == "Player":
		# Notify the main scene we won
		get_tree().root.get_node("Node").game_over(true)
		queue_free()  # Remove collectible from scene
