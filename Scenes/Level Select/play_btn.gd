extends Button
var group = load("res://Scenes/Local Multiplayer/new_button_group.tres")
var dc = {"Map": "res://Assets/Background/Level Two/lvl_two.tscn", "Map1": "res://Assets/Background/Extra Map/multimap.tscn", "Map3": "res://Assets/Background/Level One/tut_back.tscn", "Map2": "res://Assets/Background/Real Level One/lvl_one.tscn"}
var chosen_map = null


func _on_pressed() -> void:
	MapData.name_1 = %"Name 1".text
	MapData.name_2 = %"Name 2".text
	MapData.trail_1 = %"Trail Color 1".color
	MapData.trail_2 = %"Trail Color 2".color
	MapData.ball_1 = %"Ball Color 1".color
	MapData.ball_2 = %"Ball Color 2".color
	var all_nodes = get_all_nodes(get_tree().get_root())
	print("All nodes in tree:")
	for node in all_nodes:
		if "Map" in node.name and node is Button:
			print(node.name)
			if node.button_pressed:
				chosen_map = node.name
	var stage_scene = load("res://Scenes/Local Multiplayer/placeholder.tscn")
	if chosen_map != null:
		MapData.map_data = dc[chosen_map]
		get_tree().change_scene_to_file("res://Scenes/Local Multiplayer/placeholder.tscn")
	else:
		pass
	

func get_all_nodes(node: Node) -> Array:
	var result := []
	for child in node.get_children():
		result.append(child)
		result += get_all_nodes(child)  # Recursively add deeper children
	return result
