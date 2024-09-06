extends Control

@export var Address = "127.0.0.1"
@export var Port = 8910
@onready var RoomName = $RoomNameInputArea/LineEditRoom
@onready var RoomPass = $RoomPassInputArea/LineEditPassword

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
	print("Room Name: " + RoomName.text)
	if RoomPass.text != "":
		print("Room Password" + RoomPass.text)

func connection_failed(_id):
	print("Connection Failed")
	
#Button back to main menu
func _on_texture_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

#Button to the game room
func _on_start_button_pressed():
	var room_name = RoomName.text
	var room_pass = RoomPass.text
	#saves the room data in room manager script
	if room_name == "":
		print("Room Name cannot be empty")
		return
	RoomManager.add_room(room_name,room_pass != "",room_pass,Address,Port)
	print("Room created: " + room_name)
	
	
	#server set up
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(Port,5)
	if error != OK:
		print("Cannot host: " + str(error))
		return
	
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	
	multiplayer.set_multiplayer_peer(peer)
	print("waiting for players")
	#emit_signal("room_created")
	#print("Room Name: " + RoomName.text)
	#if RoomPass.text != "":
		#print("Room Password: " + RoomPass.text)
	
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
