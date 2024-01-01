extends Node2D

var peer = ENetMultiplayerPeer.new()
@onready var multiplayer_spawner = $MultiplayerSpawner
@onready var text_edit = $TextEdit

#const one_prop_prefab = preload("res://Scenes/Prefabs/Players/Props/Prop_Brazier1.tscn")

const hunter_prefab = preload("res://Scenes/Prefabs/Players/hunter.tscn")
const prop_prefabs:Array = [preload("res://Scenes/Prefabs/Players/Props/Prop_Brazier1.tscn"),
preload("res://Scenes/Prefabs/Players/Props/Prop_Brazier1_lit.tscn"),
preload("res://Scenes/Prefabs/Players/Props/Prop_Brazier2.tscn"),
preload("res://Scenes/Prefabs/Players/Props/Prop_Brazier2_lit.tscn"),
preload("res://Scenes/Prefabs/Players/Props/Prop_Chest1.tscn"),
preload("res://Scenes/Prefabs/Players/Props/Prop_Chest2.tscn"),
preload("res://Scenes/Prefabs/Players/Props/Prop_Chest3.tscn"),
preload("res://Scenes/Prefabs/Players/Props/Prop_Chest4.tscn"),
preload("res://Scenes/Prefabs/Players/Props/Prop_Chest5.tscn"),
preload("res://Scenes/Prefabs/Players/Props/Prop_Chest.tscn"),
preload("res://Scenes/Prefabs/Players/Props/Prop_Coin.tscn"),
preload("res://Scenes/Prefabs/Players/Props/Prop_Health.tscn"),
preload("res://Scenes/Prefabs/Players/Props/Prop_Health_small.tscn"),
preload("res://Scenes/Prefabs/Players/Props/Prop_Key.tscn"),
preload("res://Scenes/Prefabs/Players/Props/Prop_Mana.tscn"),
preload("res://Scenes/Prefabs/Players/Props/Prop_Mana_small.tscn"),
preload("res://Scenes/Prefabs/Players/Props/Prop_Skull_bone.tscn"),
preload("res://Scenes/Prefabs/Players/Props/Prop_Torch.tscn"),
preload("res://Scenes/Prefabs/Players/Props/Prop_Torch_flat.tscn"),
preload("res://Scenes/Prefabs/Players/Props/Prop_Torch_off.tscn")]

@onready var tile_map = $TileMap
@onready var host = $Host
@onready var join = $Join
@onready var camera_2d = $Camera2D

var client_list:Array
var item_list:Array
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_scene_paths():
	@warning_ignore("unassigned_variable")
	var paths:Array
	var dir = DirAccess.open(DataProvider.item_path)
	for file in dir.get_files():
		if file.ends_with(".tscn"):
			paths.append(DataProvider.item_path+file)
	return paths

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func disable_UI():
	host.visible = false
	join.visible = false
	text_edit.visible = false
	camera_2d.queue_free()

func _on_host_pressed():
	peer.create_server(123)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(add_player)
	multiplayer.peer_disconnected.connect(remove_player)
	disable_UI()
	var hunter = hunter_prefab.instantiate()
	hunter.set_multiplayer_authority(1)
	add_child.call_deferred(hunter)
	
	item_list = tile_map.populate_map()

func _on_join_pressed():
	peer.create_client(text_edit.text, 123)
	multiplayer.multiplayer_peer = peer
	disable_UI()


func add_player(id:int):
	var prop = prop_prefabs.pick_random().instantiate()
	prop.name = "Prop_" + str(id)
	add_child(prop)
	
	var cell = tile_map.get_used_cells(0).pick_random()
	var new_position = tile_map.to_global(tile_map.map_to_local(cell))
	prop.rpc_id(id,"set_starting_position",new_position)
	
	for item in item_list:
		item.rpc_id(id, "set_local_player",prop.get_path())

func remove_player(id:int):
	_del_player.rpc(id)
	pass

@rpc("any_peer","call_local")
func _del_player(id):
	if get_node_or_null("Prop" + str(id)):
		get_node("Prop" + str(id)).queue_free()
