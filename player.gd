extends CharacterBody2D

signal died 

const SPEED = 300.0
const JUMP_VELOCITY = -700.0

var life: int = 100

func _ready():
	update_life_ui()
	add_to_group("player")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func take_damage(amount: int):
	life -= amount
	update_life_ui()
	flash_red()
	if life <= 0:
		die()

func update_life_ui():
	var life_label = get_node_or_null("../UI/LifeLabel")
	if life_label:
		print("LifeLabel found using relative path!")	
		life_label.text = "Life: %d" % life
	else:
		print("LifeLabel not found — check your UI path!")

func die():
	print("Player has died!")
	emit_signal("died") 
	
func flash_red():
	var sprite = get_node_or_null("Sprite2D")
	if sprite:
		sprite.modulate = Color(1, 0, 0)  
		await get_tree().create_timer(0.1).timeout
		sprite.modulate = Color(1, 1, 1) 
		
func apply_knockback(from_position: Vector2, force: float):
	var direction = (global_position - from_position).normalized()
	velocity += direction * force
