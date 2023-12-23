class_name RandomItemSpawner
extends Node2D

const items:Array = [preload("res://Scenes/Prefabs/Items/Brazier1.tscn"),
preload("res://Scenes/Prefabs/Items/Brazier1_lit.tscn"),
preload("res://Scenes/Prefabs/Items/Brazier2.tscn"),
preload("res://Scenes/Prefabs/Items/Brazier2_lit.tscn"),
preload("res://Scenes/Prefabs/Items/Chest1.tscn"),
preload("res://Scenes/Prefabs/Items/Chest2.tscn"),
preload("res://Scenes/Prefabs/Items/Chest3.tscn"),
preload("res://Scenes/Prefabs/Items/Chest4.tscn"),
preload("res://Scenes/Prefabs/Items/Chest5.tscn"),
preload("res://Scenes/Prefabs/Items/Chest.tscn"),
preload("res://Scenes/Prefabs/Items/Coin.tscn"),
preload("res://Scenes/Prefabs/Items/Health.tscn"),
preload("res://Scenes/Prefabs/Items/Health_small.tscn"),
preload("res://Scenes/Prefabs/Items/Key.tscn"),
preload("res://Scenes/Prefabs/Items/Mana.tscn"),
preload("res://Scenes/Prefabs/Items/Mana_small.tscn"),
preload("res://Scenes/Prefabs/Items/Skull_bone.tscn"),
preload("res://Scenes/Prefabs/Items/Torch.tscn"),
preload("res://Scenes/Prefabs/Items/Torch_flat.tscn"),
preload("res://Scenes/Prefabs/Items/Torch_off.tscn")]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
static func spawn_random_item():
	return items.pick_random().instantiate()

static func get_item_list():
	return items
