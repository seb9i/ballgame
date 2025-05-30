extends Node2D

@onready var ambience = $ambience
@onready var swish = $net
@onready var camera = $Camera2D
@onready var completed = false
@onready var scoreboard_dropped = false

func _ready():
	$Scoreboard.position = Vector2(480, -350)
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Dialogic.signal_event.connect(_on_timeline_ended)
	Dialogic.start('tutorial')
	ambience.play()
	await Dialogic.timeline_ended
	get_tree().change_scene_to_file("res://Scenes/Level One/Level One.tscn")
	
func _process(delta):

	if (Scoreboard.score >= 2 and scoreboard_dropped):
		Dialogic.paused = false
		camera.activateDefense()
		completed = true
	if (camera.enabled_shake == true and not completed):
		camera.apply_shake(5)

func _on_dialogic_signal(argument:String):
	if argument == "shooting":
		var shape_world_pos = $Basketball.collision_shape.global_position
		print($Basketball.toss_ball_parabola($Basketball.collision_shape2.global_position, 70))

	if argument == "shake":
		camera.apply_shake()
	if argument == "wow":
		Dialogic.paused = true
		camera.activateDefense()
	if argument == "show_score":
		$Scoreboard.show_score()
		scoreboard_dropped = true
	
func _on_timeline_ended():
	get_tree().change_scene_to_file("res://Scenes/Level One/Level One.tscn")
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)




	
	
func _unhandled_input(event) -> void:
	

	
	if Input.is_action_just_pressed("Left"):
		pass

func _on_ambience_finished() -> void:
	pass # Replace with function body.


func _on_sound_trigger_body_entered(body):
	pass # Replace with function body.
