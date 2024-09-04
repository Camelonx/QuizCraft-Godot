extends Control
func _ready():
	pass
func _on_create_room_pressed():
	get_tree().change_scene_to_file("res://Scenes/create_room.tscn")


func _on_join_room_pressed():
	get_tree().change_scene_to_file("res://Scenes/join_room.tscn")
