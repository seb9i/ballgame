extends Button
var original_size := size
var grow_size := Vector2(1.1, 1.1)


func _on_mouse_exited() -> void:
	pass
	
func grow_size_tween(end_size: Vector2, duration: float) -> void:
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, 'scale', end_size, duration) 
	
	
func _on_mouse_entered() -> void:
	pass


func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Level One/Level One.tscn")
