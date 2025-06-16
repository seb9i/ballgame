extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Dialogic.start("level_two")
	Dialogic.signal_event.connect(_on_dialogic_signal)
	$Basketball.allow_input = false
	await Dialogic.timeline_ended
	get_tree().change_scene_to_file("res://Scenes/Level Select/control.tscn")



func _on_dialogic_signal(argument:String):
	if argument == "show":
		$Scoreboard.show_score()
		$Timer.show_score(850)
	if argument == "start":
		Dialogic.paused = true
		$Basketball.allow_input = true
		$Timer.start_time()
		await $Timer.finished 
		Dialogic.paused = false
		$Basketball.allow_input = false
		$Basketball.meter.visible = false
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
