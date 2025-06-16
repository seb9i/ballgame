extends Node2D
var horse_enabled = false

var player_one = true
var ai = false
var previous_position = null
var string_1 = "PIG"

var ai_turn = true



signal shots
# Called when the node enters the scene tree for the first time.
func _ready():
	Dialogic.start("Level_One")
	Scoreboard.shot_made = false
	$Basketball.allow_input = false
	Dialogic.signal_event.connect(_on_dialogic_signal)
	await Dialogic.timeline_ended
	get_tree().change_scene_to_file("res://Scenes/Level Two/level_two.tscn")

func swap_positions():
		print("swap positions")
		if player_one:
			player_one = false
			ai = true
			Scoreboard.player_turns -= 1
			GlobalPig.label_1 += string_1[2 - Scoreboard.player_turns] + "."
			GlobalPig.label_3 = "Swapping possessions - other player picks the shot positions"
			await get_tree().create_timer(1.5).timeout
			GlobalPig.label_3 = ""
		else:

			player_one = true
			ai = false
			Scoreboard.ai_turns -= 1
			GlobalPig.label_2 += string_1[2 - Scoreboard.ai_turns] + "."
			GlobalPig.label_3 = "Swapping possessions - you player picks the shot positions"
			await get_tree().create_timer(1.5).timeout
			GlobalPig.label_3 = ""
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if horse_enabled:
		var mouse_position_x = get_global_mouse_position().x - 50
		var mouse_position_y = get_global_mouse_position().y
		$Basketball.global_position = Vector2(mouse_position_x, mouse_position_y)

func doThing():

	while Scoreboard.player_turns > 0 and Scoreboard.ai_turns > 0:
		await get_tree().create_timer(.2).timeout
		
		if player_one:
			activate_horse(true)
			print("Awaiting shot")
			await Scoreboard.shot
			print("Shot the ball")
			if (Scoreboard.shot_made == false):

				swap_positions()
				continue


			$Basketball.allow_input = false
			await get_tree().create_timer(1.5).timeout

			var ai_shot = randf_range($Basketball.ai_percentages(), 100)
			if ai_shot > 80:

				$Basketball.toss_ball_parabola($Basketball.collision_shape2.global_position, 70)
			else:
				$Basketball.toss_ball_parabola($Basketball.collision_shape2.global_position, 70, ai_shot)	
			print("Awaiting ai shot")
			await Scoreboard.shot
			print("AI shot the ball")
			if (Scoreboard.shot_made == false):
				print("ai missed")
				Scoreboard.ai_turns -= 1
				GlobalPig.label_2 += string_1[2 - Scoreboard.ai_turns] + "."
				
		if ai:
			
			$Basketball.allow_input = false
			await get_tree().create_timer(1.5).timeout
			previous_position = $Basketball.global_position
			print("Previous position at " + str(previous_position))
			$Basketball.override = true
			print($Basketball.override)
			$Basketball.override_location = previous_position
			var ai_shot = randf_range($Basketball.ai_percentages(), 100)
			if ai_shot > 85:

				$Basketball.toss_ball_parabola($Basketball.collision_shape2.global_position, 70)
			else:

				$Basketball.toss_ball_parabola($Basketball.collision_shape2.global_position, 70, ai_shot)
			print("AI TURN- AI SHOT")
			await Scoreboard.shot

			if (Scoreboard.shot_made == false):
				swap_positions()
				continue
			
			print("AI TURN- PLAYER_SHOT")
			await get_tree().create_timer(.1).timeout
			await Scoreboard.shot
			if (Scoreboard.shot_made == false):
				Scoreboard.player_turns -= 1
				GlobalPig.label_1 += string_1[2 - Scoreboard.player_turns] + "."
	Dialogic.paused = false
		
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
		Dialogic.paused = true
		$Basketball.allow_input = true
		doThing()


func _unhandled_input(event) -> void:
	if Input.is_action_just_pressed("Left"):
		activate_horse(true)
	if Input.is_action_just_released("Shoot") and player_one:
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
