extends Button

func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Main Menu/main_menu.tscn")
	Dialogic.end_timeline()
