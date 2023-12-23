extends Node2D

@export var texture:Texture2D
@export var valid_sprite_coordinates_outlier:Array
@export var valid_sprite_coordinates_start:Vector2i
@export var valid_sprite_coordinates_end:Vector2i

@export var sprite_size:Vector2i
var local_player

var item_sprite
var ray_cast:RayCast2D
var collision_shapes:Array

func _ready():
	item_sprite = randomize_visual(create_valid_sprite_coordinates())
	
	
	

func create_valid_sprite_coordinates():
	var valid_sprite_coordinates = valid_sprite_coordinates_outlier
	var valid_x = range(valid_sprite_coordinates_start.x, valid_sprite_coordinates_end.x+1)
	var valid_y = range(valid_sprite_coordinates_start.y, valid_sprite_coordinates_end.y+1)
	
	for x in valid_x:
		for y in valid_y:
			valid_sprite_coordinates.append(Vector2i(x,y))
	print(valid_sprite_coordinates)
	return valid_sprite_coordinates
	

func randomize_visual(valid_sprite_coordinates):
	# load texture atals
	
	# choose random item from valid atlas positions
	# cut item from atlas (rectangle size specific to atlas used)
	for vector in valid_sprite_coordinates:
		var atlas_texture = AtlasTexture.new()
		atlas_texture.set_atlas(texture)
			
		var rectangle = Rect2(vector*sprite_size,sprite_size)
		atlas_texture.region = rectangle
		item_sprite = Sprite2D.new()
		item_sprite.name = "ItemSprite"
		item_sprite.texture = atlas_texture
		item_sprite.centered = false
		
		var new_node = RigidBody2D.new()
		
		new_node.name = "Item_" + str(vector)

		
		make_collision_polygon(item_sprite, new_node)
		
		new_node.add_child(item_sprite)
		add_child(new_node)
		new_node.global_position = vector * 4
	
	# so we do not have to care about offsets when working with this	
func get_collider_position():
	return to_global(item_sprite.position) + (sprite_size * 0.5)




func make_collision_polygon(sprite:Sprite2D, parent_node):
	# Create a BitMap from the sprite's texture, alpha only (visibility of pixels)
	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(sprite.texture.get_image())
	# Generate polygons from bitmap
	var polygons = bitmap.opaque_to_polygons(Rect2(Vector2(), sprite.texture.get_size()))
	# for each polygon onf the bitmap...
	var counter = 0
	for polygon in polygons:
		# ...create a CollisionPolygon
		var collision_polygon = CollisionPolygon2D.new()
		collision_polygon.name = "Collision" + str(counter)
		counter += 1
		collision_polygon.set_polygon(polygon)
		# Add the CollisionPolygon2D as a child of the RigidBody
		parent_node.add_child(collision_polygon)
		collision_shapes.append(collision_polygon)
