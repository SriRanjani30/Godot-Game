extends Node

@onready var message_label = $UI/MessageLabel 

var CollectibleScene = preload("res://collectible.tscn")
var spawn_points = []

func _ready():
	spawn_points = [
		$Spawn1.position,
		$Spawn2.position,
		$Spawn3.position,
		$Spawn4.position,
		$Spawn5.position,
		$Spawn6.position,
		$Spawn7.position,
		$Spawn8.position,
		$Spawn9.position,
		$Spawn10.position,
	]

	var player = get_node("Player")
	if player:
		player.connect("died", Callable(self, "_on_player_died"))
	else:
		print("Player node not found!")

	spawn_collectible()

	var collectible = get_node_or_null("TileMapLayer/Collectible")
	if collectible:
		collectible.connect("collected", Callable(self, "_on_collectible_collected"))
	else:
		print("Collectible not found!")
	
		
func spawn_collectible():
	randomize() 

	var collectible = CollectibleScene.instantiate()
	var chosen_position = spawn_points[randi() % spawn_points.size()]
	collectible.position = chosen_position
	add_child(collectible)
	collectible.connect("collected", Callable(self, "game_over").bind(true))


func _on_player_died():
	print("Game Over: Player died!")
	game_over(false)

func _on_collectible_collected():
	print("Player won the game!")
	game_over(true)

func game_over(won: bool):
	if won:
		message_label.text = "You found the gem! You win!"
	else:
		message_label.text = "Your life reached 0! You lose!"
	get_tree().paused = true 
	

	
