extends Control

@export var Address = "127.0.0.1"
@export var Port = 8910
var peer
func _ready():
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)
	pass


func peer_connected(id):
	print("Player Connected: " + str(id))

func peer_disconnected(id):
	print("Player Disconnected: " + str(id))

func connected_to_server(_id):
	print("Connected to Server")

func connection_failed(_id):
	print("Connection Failed")
	
#Button back to main menu
func _on_texture_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

#Button to the game room
func _on_start_button_pressed():
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(Port,5)
	if error != OK:
		print("Cannot host: " + str(error))
		return
	
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	
	multiplayer.set_multiplayer_peer(peer)
	print("waiting for players")
	
	#get_tree().change_scene_to_file("res://Scenes/game_room.tscn")

func _join_Button():
	peer = ENetMultiplayerPeer.new()
	peer.create_client(Address,Port)
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)


func _on_join_test_pressed():
	peer = ENetMultiplayerPeer.new()
	peer.create_client(Address,Port)
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)
	pass # Replace with function body.
