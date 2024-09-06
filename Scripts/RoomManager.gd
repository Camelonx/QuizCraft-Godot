extends Node
signal room_created
# Dictionary to hold room data
var rooms = {}
func _ready():
	pass

# Function to add a new room
func add_room(roomname: String, has_password: bool, password: String = "", ip_address: String = "", port: int = 8910):
	rooms[roomname] = {
	"has_password": has_password,
	"password": password,
	"ip_address": ip_address,
	"port": port
	}
	
	print("Current rooms: " , rooms)
	emit_signal("room_created")
	
# Function to retrieve room data
func get_room_data(roomname: String):
	# Return room data or null if it doesn't exist
	return rooms.get(roomname, null)


