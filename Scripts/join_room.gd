extends Control
var peer;
@export var Address = "127.0.0.1"
@export var Port = 8910
@onready var SearchRoomName = $SearchName/LineEditSearchName
@onready var SearchRoomPass = $EnterPassword/LineEditRoomPassword
@onready var RoomListContainer = $Panel/RoomListContainer


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_search_button_pressed():
	var room_name = SearchRoomName.text
	var room_pass = SearchRoomPass.text
	
	#Checks if the Room exists
	var room_data = RoomManager.get_room_data(room_name)
	
	if room_data == null:
		print("Room name does not exist")
		return
	if room_data.has_password:
		if room_pass == "":
			print("Room password is required")
			return
		elif room_pass != room_data.password:
			print("Room Password is wrong")
			return
	#if room exist and does not have a password
	join_room(room_name)
	#peer.create_client(Address,Port)
	#peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	#multiplayer.set_multiplayer_peer(peer)
	
	#get_tree().change_scene_to_file("res://Scenes/game_room.tscn")
func join_room(room_name):
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_client(Address, Port)
	if error != OK:
		print("Cannot connect to server: " + str(error))
		return
	
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)
	print("Joining Room: " + room_name)
	#get_tree().change_scene_to_file("res://Scenes/game_room.tscn")  # Proceed to game room
func _ready():
	
	update_room_list()
	
func _on_room_created():
	update_room_list()
	
func update_room_list():
	#RoomListContainer.clear_children()
	
	for room_name in RoomManager.rooms.keys():
		var room_label = Label.new()
		room_label.text = room_name
		RoomListContainer.add_child(room_label)
