class_name PropItem
extends Node2D

var local_player
var sprite_size:Vector2i = Vector2i(16,16)
var ray_cast:RayCast2D
const HIDDEN_MATERIAL = preload("res://Assets/HiddenMaterial.tres")

@onready var item_sprite = $ItemSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	item_sprite.material = HIDDEN_MATERIAL
	item_sprite.centered = false
	local_player = get_node_or_null("/root/World/Hunter")
	if(local_player == null):
		local_player = self
		print("could not find local_player")
	init_raycast()
	
func set_local_player(player_node):
	local_player = player_node
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):	
	# check for line of sight to hunter, disable if not
	# needed as hiding items using lighting ignores walls
	ray_cast.target_position =  local_player.position - to_global(ray_cast.position)
	var collision = ray_cast.get_collider()
	if not collision == null:
		set_visibility(collision.name == local_player.name)



func set_visibility(new_visibility):
	item_sprite.visible = new_visibility


	
func init_raycast():
	ray_cast = RayCast2D.new()
	ray_cast.set_collision_mask_value(8, true)
	ray_cast.set_collision_mask_value(1, false)
	ray_cast.position = item_sprite.position
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
