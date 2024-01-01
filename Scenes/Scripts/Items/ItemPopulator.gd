extends TileMap

@export_range (0 ,1) var item_on_tile_propability:float
# Called when the node enters the scene tree for the first time.
func populate_map():
	var counter = 0
	@warning_ignore("unassigned_variable")
	var item_list:Array
	for cell in get_used_cells(0):
		if(randf() < item_on_tile_propability):
			var new_item = spawn_random_item()
			new_item.name = "Item_" + str(counter)
			counter += 1
			new_item.position = to_global(map_to_local(cell)) + Vector2(randf_range(-2,-2), randf_range(-2,2))
			add_sibling.call_deferred(new_item)
			item_list.append(new_item.get_node("ItemSprite"))
	return item_list

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func spawn_random_item():
	var item:RigidBody2D = RandomItemSpawner.spawn_random_item()
	item.lock_rotation = true
	item.rotation = 0
	item.linear_damp = 10
	return item

