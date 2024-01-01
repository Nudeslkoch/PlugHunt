extends PropItem
@onready var hunter = $/root/World/Hunter
@onready var vibration_manager = $/root/World/%VibrationManager

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	local_player = hunter
	if not is_multiplayer_authority():
		ray_cast.queue_free()

# modified from prop to only change on hunter
func _process(_delta):
	if not is_multiplayer_authority():
		return
	# check for line of sight to hunter, disable if not
	# needed as hiding items using lighting ignores walls
	var target_pos = local_player.position
	if local_player_is_prop:
		target_pos += sprite_size * 0.5
	ray_cast.target_position = target_pos  - to_global(ray_cast.position)
	var collision = ray_cast.get_collider()
	if not collision == null:
		rpc_id(1,"set_visibility",collision.name == local_player.name)
	do_the_bzz()

func do_the_bzz():
	var adjusted_position = global_position + sprite_size * 0.5
	var distance = adjusted_position.distance_to(hunter.global_position)
	print("distance: " + str(distance))
	distance = clampi(distance -15, 0 , 150)
	if distance > 150:
		vibration_manager.set_new_strength(0)
	else:
		vibration_manager.set_new_strength(100 - distance/1.5)
