extends Node2D
var horse_enabled = false
signal shot
# Called when the node enters the scene tree for the first time.
func _ready():
	Dialogic.start("Level_One")
	Dialogic.signal_event.connect(_on_dialogic_signal)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if horse_enabled:
		var mouse_position_x = get_global_mouse_position().x - 50
		var mouse_position_y = get_global_mouse_position().y
		$Basketball.global_position = Vector2(mouse_position_x, mouse_position_y)
		print("Basketball Position: " + str($Basketball.position) + " Mouse Position: " + str(Vector2(mouse_position_x, mouse_position_y)))


func activate_horse(boolean = false):
	if boolean:
		horse_enabled = true
		$Basketball.make_transparent(true)
		$Basketball.allow_input = false
	else:
		horse_enabled = false
		$Basketball.make_transparent(false)
		$Basketball.allow_input = true
		

func _on_dialogic_signal(argument:String):
	if argument == "Pick":
		activate_horse(true)
		Dialogic.paused = true


func _unhandled_input(event) -> void:
	if Input.is_action_just_pressed("Left"):
		activate_horse(true)
	if Input.is_action_just_released("E"):
		shot.emit()
	if Input.is_action_just_pressed("Click"):
		activate_horse(false)

		await shot
		Dialogic.paused = false

	


func _on_sound_trigger_body_entered(body):
	if (body.name == "Basketball" and $Basketball.is_shot):
		Dialogic.paused = false;
