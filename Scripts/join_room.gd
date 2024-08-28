extends Control
var peer;
@export var Address = "127.0.0.1"
@export var Port = 8910
func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_search_button_pressed():
	peer = ENetMultiplayerPeer.new()
	peer.create_client(Address,Port)
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)
	
	#get_tree().change_scene_to_file("res://Scenes/game_room.tscn")
	
