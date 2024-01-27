extends MultiplayerSpawner

const scenes_to_add:Array = [("res://Scenes/Prefabs/Players/Props/Prop_Brazier1.tscn"),
("res://Scenes/Prefabs/Players/Props/Prop_Brazier1_lit.tscn"),
("res://Scenes/Prefabs/Players/Props/Prop_Brazier2.tscn"),
("res://Scenes/Prefabs/Players/Props/Prop_Brazier2_lit.tscn"),
("res://Scenes/Prefabs/Players/Props/Prop_Chest1.tscn"),
("res://Scenes/Prefabs/Players/Props/Prop_Chest2.tscn"),
("res://Scenes/Prefabs/Players/Props/Prop_Chest3.tscn"),
("res://Scenes/Prefabs/Players/Props/Prop_Chest4.tscn"),
("res://Scenes/Prefabs/Players/Props/Prop_Chest5.tscn"),
("res://Scenes/Prefabs/Players/Props/Prop_Chest.tscn"),
("res://Scenes/Prefabs/Players/Props/Prop_Coin.tscn"),
("res://Scenes/Prefabs/Players/Props/Prop_Health.tscn"),
("res://Scenes/Prefabs/Players/Props/Prop_Health_small.tscn"),
("res://Scenes/Prefabs/Players/Props/Prop_Key.tscn"),
("res://Scenes/Prefabs/Players/Props/Prop_Mana.tscn"),
("res://Scenes/Prefabs/Players/Props/Prop_Mana_small.tscn"),
("res://Scenes/Prefabs/Players/Props/Prop_Skull_bone.tscn"),
("res://Scenes/Prefabs/Players/Props/Prop_Torch.tscn"),
("res://Scenes/Prefabs/Players/Props/Prop_Torch_flat.tscn"),
("res://Scenes/Prefabs/Players/Props/Prop_Torch_off.tscn")]

# Called when the node enters the scene tree for the first time.
func _ready():
	for scene in scenes_to_add:
		add_spawnable_scene(scene)
