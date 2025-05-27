extends Node2D
var horse_enabled = false
var player_turns = 3
var ai_turns = 3
var player_one = true
var ai = false
var previous_position = null
var player_one_made_shot = true
var ai_turn = true

signal shots
# Called when the node enters the scene tree for the first time.
func _ready():
	Dialogic.start("Level_One")
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Scoreboard.shot.connect(doThing)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if horse_enabled:
		var mouse_position_x = get_global_mouse_position().x - 50
		var mouse_position_y = get_global_mouse_position().y
		$Basketball.global_position = Vector2(mouse_position_x, mouse_position_y)

func doThing():
	if player_turns <= 0 or ai_turns <= 0:
		return
	if Scoreboard.shot_made == false:
		if player_one:
			player_one = false
			ai = true
			player_turns -= 1
		else:
			player_one = true
			ai = false
			ai_turns -= 1
	else:
		
	
		if player_one:
			print("player one made the first shot")
			$Basketball.allow_input = false
			await get_tree().create_timer(1.5).timeout
			var ai_shot = randf_range(70, 100)
			if ai_shot > 60:

				$Basketball.toss_ball_parabola($Basketball.collision_shape2.global_position, 70, $Basketball)
			else:


				$Basketball.toss_ball_parabola($Basketball.collision_shape2.global_position, 70, $Basketball, ai_shot)
			print("Player ONE Main turn")
				
				
		if ai:
			print("ai made the first shot")
			$Basketball.allow_input = false
			await get_tree().create_timer(1.5).timeout
			var ai_shot = randf_range(70, 100)
			if ai_shot > 60:

				$Basketball.toss_ball_parabola($Basketball.collision_shape2.global_position, 70, $Basketball)
			else:


				$Basketball.toss_ball_parabola($Basketball.collision_shape2.global_position, 70, $Basketball, ai_shot)
				print("shot didn't go in.")
			print("AI Main Turn")
		
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
	if Input.is_action_just_released("Shoot") and $Basketball.allow_input:
		previous_position = $Basketball.global_position
		print("Previous position at " + str(previous_position))
		$Basketball.override = true
		print($Basketball.override)
		$Basketball.override_location = previous_position
	if Input.is_action_just_pressed("Click") and horse_enabled:

		activate_horse(false)
		await shots
		Dialogic.paused = false
		
		


func _on_sound_trigger_body_entered(body):
	pass # Replace with function body.
