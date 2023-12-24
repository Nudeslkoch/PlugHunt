extends Player

@onready var animation_player = $Animations/AnimationPlayer


func player_movement():
	super.player_movement()
	var currentInput = get_input()
	if currentInput == Vector2i.ZERO:
		animation_player.play("Idle")
	else:
		if currentInput.x > 0:
			animation_player.play("Walk_left")
			# TODO maybe make this remember last facing
		else:
			animation_player.play("Walk_right")
