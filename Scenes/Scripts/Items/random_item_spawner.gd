class_name RandomItemSpawner
extends Node2D

const item = preload("res://Scenes/Prefabs/Item_skin_changer.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
static func spawn_random_item():
	var new_item = item.instantiate()
	new_item.get_node_or_null("ItemSprite").set_skin(randi_range(0,19))
	return new_item

static func get_item_list():
	return item
