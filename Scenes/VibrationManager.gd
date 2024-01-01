extends Control

signal change_device_strength(new_value)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func set_new_strength(value:float):
	print(value)
	change_device_strength.emit(value)
