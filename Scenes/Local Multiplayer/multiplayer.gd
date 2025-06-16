extends Node2D
@onready var map_holder = $"Map Placeholder"
var gradient_data := {

0.75: MapData.trail_2
}
var gradient := Gradient.new()
var gradient_data_2 := {

0.75: MapData.trail_1
}
var gradient_2 := Gradient.new()

func _ready():
	Dialogic.start("multiplayer")
	Dialogic.signal_event.connect(_on_dialogic_signal)
	$Basketball.allow_input = false
	$Basketball2.allow_input = false
	gradient.offsets = gradient_data.keys()
	gradient.colors = gradient_data.values()
	
	gradient_2.offsets = gradient_data_2.keys()
	gradient_2.colors = gradient_data_2.values()
	load_map(MapData.map_data)
	$Basketball/Sprite2D.material.set_shader_parameter("color", MapData.ball_1)
	$Basketball2/Sprite2D.material.set_shader_parameter("color", MapData.ball_2)
	$Basketball/trail.gradient = gradient
	$Basketball2/trail.gradient = gradient_2
	$Scoreboard/Label2.text = MapData.name_2
	$Scoreboard2/Label2.text = MapData.name_1
	await $Timer.finished
	Dialogic.paused = false
	$Basketball.allow_input = false
	$Basketball2.allow_input = false
	await Dialogic.timeline_ended
	Scoreboard.score = 0
	Scoreboard.score_1 = 0
	get_tree().change_scene_to_file("res://Scenes/Local Multiplayer/control.tscn")
	
func _on_dialogic_signal(argument:String):
	if argument == "drop":
		Dialogic.paused = true
		$Basketball.allow_input = true
		$Basketball2.allow_input = true
		$Timer.show_score()
		$Timer.set_time(50)
		$Timer.start_time()
func load_map(map_path: String):
	var map_scene = load(map_path)
	var map_instance = map_scene.instantiate()
	map_holder.add_child(map_instance)
