extends Control

func _on_texture_button_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://game_room.tscn")
