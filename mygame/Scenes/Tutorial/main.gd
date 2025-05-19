extends Node2D

@onready var ambience = $ambience
@onready var swish = $net
@onready var camera = $Camera2D
@onready var completed = false
@onready var scoreboard_dropped = false

func _ready():
	$Scoreboard.position = Vector2(480, -350)
	Dialogic.signal_event.connect(_on_dialogic_signal)

	Dialogic.start('tutorial')

	ambience.play()
	
func _process(delta):
	print(get_global_mouse_position())
	if (Scoreboard.score >= 5 and scoreboard_dropped):
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
		var tween = create_tween()
		tween.tween_property($Scoreboard, "position", Vector2(480, -203), 2).from(Vector2(480, -350))
		Scoreboard.score = 0
		scoreboard_dropped = true
	print(argument)


	
	
func _unhandled_input(event) -> void:
	

	
	if Input.is_action_just_pressed("Left"):
		pass

func _on_ambience_finished() -> void:
	pass # Replace with function body.


func _on_area_2d_body_entered(body) -> void:
	if (body.name == "Basketball"):
		swish.play()
		Scoreboard.score += 1
		
