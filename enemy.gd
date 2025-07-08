extends CharacterBody2D

@export var attack_damage: int = 10


func _on_attack_area_body_entered(body: Node2D) -> void:
	print("AttackArea triggered by:", body.name)
	attack_player(body)

func attack_player(player: Node):
	print("Attacking player!")
	if player.has_method("take_damage"):
		player.take_damage(attack_damage)
	if player.has_method("apply_knockback"):
		player.apply_knockback(global_position, 500)  
