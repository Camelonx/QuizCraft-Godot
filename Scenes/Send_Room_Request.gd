extends HTTPRequest
const host: String = "https://quizcraft-c7c6f-default-rtdb.asia-southeast1.firebasedatabase.app/"

var is_request_pending: bool = false
var prev_Room_Data_json :String


func _ready():
	get_tree().set_auto_accept_quit(false)
	request_completed.connect(_on_request_complete)
	prev_Room_Data_json = ""

func _notification(what) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		_delete_room_server()
func _delete_room_server() -> void:
	for roomname in RoomManager.rooms.keys():
		var Room_Data = RoomManager.get_room_data(roomname)
		var Room_Data_json = JSON.stringify(Room_Data)
		
		var url = _get_player_url(roomname)
		is_request_pending = true
		var err = request(url, [], HTTPClient.METHOD_DELETE)  # Send DELETE request
		if err != OK:
			printerr("Failed to start delete request: %s" % err)
		await request_completed
		get_tree().quit()
func _on_request_complete(
	result: int,
	response_code: int,
	_headers: PackedStringArray,
	_body: PackedByteArray,
) -> void:
	is_request_pending = false
	if result == OK:
		printerr("Request completed with response code: %d" % response_code)
	else:
		printerr("request failed with response code %d" % response_code)
	#is_request_pending = false
	

func _get_player_url(roomname: String) -> String:
	return host + ("Rooms/" + roomname +".json")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) ->void:
	if not is_request_pending:
		_send_room_info() 
	#_send_room_info() 

func _send_room_info() -> void:
	for roomname in RoomManager.rooms.keys():
		var Room_Data = RoomManager.get_room_data(roomname)
		var Room_Data_json = JSON.stringify(Room_Data)
		
		if Room_Data_json == prev_Room_Data_json:
			return
			
		prev_Room_Data_json = Room_Data_json
		var url = _get_player_url(roomname)
	
		is_request_pending = true
	
		var err = request(url,[],HTTPClient.METHOD_PUT,Room_Data_json)
		if err != OK:
			printerr("Failed to start request: %s" % err)
	
	
