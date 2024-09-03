extends Node
signal room_created
# Dictionary to hold room data
var rooms = {}

# Function to add a new room
func add_room(name: String, has_password: bool, password: String = ""):
	rooms[name] = {"has_password": has_password, "password": password}
	print("Current rooms: " , rooms)
	emit_signal("room_created")

# Function to retrieve room data
func get_room_data(name: String):
	return rooms.get(name, null)  # Return room data or null if it doesn't exist
