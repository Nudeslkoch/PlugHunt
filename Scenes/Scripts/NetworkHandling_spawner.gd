extends Node2D

var peer = ENetMultiplayerPeer.new()
@onready var multiplayer_spawner = $MultiplayerSpawner
@onready var text_edit = $TextEdit



const hunter_prefab = preload("res://Scenes/Prefabs/Players/hunter.tscn")
const prop_prefab = preload("res://Scenes/Prefabs/Players/Prop_Player.tscn")
#const prop_prefab = preload("res://Scenes/Prefabs/old/Props/Prop_Brazier1.tscn")

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
	var prop = prop_prefab.instantiate()
	prop.name = "Prop_" + str(id)
	add_child(prop)
	
	
	
	var cell = tile_map.get_used_cells(0).pick_random()
	var new_position = tile_map.to_global(tile_map.map_to_local(cell))
	prop.rpc_id(id,"set_starting_position",new_position)
	prop.get_node_or_null("ItemSprite").rpc_id(id,"set_skin",(randi_range(0,19)))
	
	for item in item_list:
		item.rpc_id(id, "set_local_player",prop.get_path())

func remove_player(id:int):
	_del_player.rpc(id)
	pass

@rpc("any_peer","call_local")
func _del_player(id):
	if get_node_or_null("Prop" + str(id)):
		get_node("Prop" + str(id)).queue_free()
