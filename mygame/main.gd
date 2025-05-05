extends Node2D

@onready var ambience = $ambience
@onready var swish = $net
@onready var camera = $Camera2D


func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Dialogic.start('tutorial')

	ambience.play()

func _on_dialogic_signal(argument:String):
	if argument == "shooting":
		var shape_world_pos = $Basketball.collision_shape.global_position
		$Basketball.toss_ball_parabola($Basketball.collision_shape2.global_position, 70)
	if argument == "shake":
		camera.apply_shake()
	print(argument)

func _unhandled_input(event) -> void:
	

	
	if Input.is_action_just_pressed("Left"):
		pass

func _on_ambience_finished() -> void:
	pass # Replace with function body.


func _on_area_2d_body_entered(body) -> void:
	if (body.name == "Basketball"):
		swish.play()
		
