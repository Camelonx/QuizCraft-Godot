extends Control



func _on_create_room_pressed():
	get_tree().change_scene_to_file("res://create_room.tscn")
