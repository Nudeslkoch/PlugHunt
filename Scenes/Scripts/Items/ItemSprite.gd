class_name PropItem
extends Sprite2D

var local_player
var sprite_size:Vector2i = Vector2i(16,16)
var ray_cast:RayCast2D
const HIDDEN_MATERIAL = preload("res://Assets/HiddenMaterial.tres")
var local_player_is_prop:bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	material = HIDDEN_MATERIAL
	centered = false
	local_player = get_node_or_null("/root/World/Hunter")
	if(local_player == null):
		local_player = self
		print("could not find local_player")
	init_raycast()
	
@rpc("reliable")
func set_local_player(player_node_path):
	var temp_node = get_node_or_null(player_node_path)
	if temp_node == null:
		print(player_node_path)
		return
	local_player_is_prop = true
	local_player = temp_node
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):	
	# check for line of sight to hunter, disable if not
	# needed as hiding items using lighting ignores walls
	var target_pos = local_player.position
	if local_player_is_prop:
		target_pos += sprite_size * 0.5
		target_pos.y += sprite_size.y * 0.2
	ray_cast.target_position = target_pos  - to_global(ray_cast.position)
	var collision = ray_cast.get_collider()
	if not collision == null:
		set_visibility(collision.name == local_player.name)


@rpc("reliable")
func set_visibility(new_visibility):
	visible = new_visibility

func init_raycast():
	ray_cast = RayCast2D.new()
	ray_cast.set_collision_mask_value(8, true)
	ray_cast.set_collision_mask_value(1, false)
	ray_cast.position = position
	ray_cast.position += sprite_size * 0.5
	add_child(ray_cast)

func get_collision_shapes():
	@warning_ignore("unassigned_variable")
	var collision_shapes:Array
	for child in get_children():
		print(child.name)
		if child is CollisionPolygon2D:
			collision_shapes.append(child)
	return collision_shapes
