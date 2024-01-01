extends Player

@rpc("reliable","any_peer")
func set_starting_position(new_position):
	position = new_position
