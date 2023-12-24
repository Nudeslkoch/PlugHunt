class_name Player
extends CharacterBody2D

func _enter_tree():
	if name == "Hunter":
		set_multiplayer_authority(1)
	else:
		var id = str(name)
		set_multiplayer_authority(int(id.split("_")[1]))

func _ready():
	if not is_multiplayer_authority():
		$Camera2D.queue_free()

	

func _process(_delta):
	pass



func _physics_process(_delta):
	if is_multiplayer_authority():
		player_movement()


func get_input():
	var buffer: Vector2i = Vector2i.ZERO
	buffer.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	buffer.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return buffer

func player_movement():
	var collision = move_and_collide(get_input())
	if not collision == null:
		if collision.get_collider() is RigidBody2D:
			collision.get_collider().apply_central_impulse(-collision.get_normal() * 10)
			


