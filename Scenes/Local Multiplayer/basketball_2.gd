extends "res://basketball.gd"
var shoot_pressed = false
func _physics_process(delta):

	bar.global_position = get_node("CollisionShape2D").global_position
	if on_floor:
		var instance = preload("res://Assets/Dust/dust.tscn").instantiate()
		
		instance.global_position.x = $CollisionShape2D.global_position.x
		instance.global_position.y = $CollisionShape2D.global_position.y + 12
		
		get_tree().current_scene.add_child(instance)
	if is_shot:
		if Time.get_unix_time_from_system() - time > 4:
			
			Scoreboard.shot_made_1 = false
			transfer_ball_random()

	pass
func _unhandled_input(event) -> void:
	var shape_world_pos = collision_shape.global_position
	 
	if not is_shot and allow_input:
		trail.visible = false
		if Input.is_action_just_pressed("shoot_2"):
			meter.shoot_pressed = true
			var distance = (collision_shape2.global_position.distance_to(global_position) / 600)
			var distance2 = (distance * 100)
			print(snapped(distance2, 70))
			meter.get_node("Timer").wait_time = 0.010 / (snapped(distance2, 70) / 70)
			#if distance2 < 50:
				#meter.get_node("Timer").wait_time = 0.003 / distance
#
			#elif distance2 < 150:
				#meter.get_node("Timer").wait_time = 0.007 / distance
#
			#else:
				#meter.get_node("Timer").wait_time = 0.010 / distance


		if Input.is_action_just_released("shoot_2"):
			meter.shoot_pressed = false

			if (collision_shape3.global_position.distance_to(get_node("CollisionShape2D").global_position) < 700):
				toss_ball_parabola(collision_shape2.global_position, 70, bar.value)



			# Far Shot	
			elif (collision_shape3.global_position.distance_to(get_node("CollisionShape2D").global_position) > 1100):

				toss_ball_parabola(collision_shape4.global_position, 60, bar.value)

			# Medium Shot	
			else:
				toss_ball_parabola(shape_world_pos, 60, bar.value)
			is_shot = true
			bar.modulate.a = 1
			bar.value = 0
			bar.visible = false
func transfer_ball_random():
	if (override):

		global_position = override_location

		override = false
	else:
		global_position = Vector2(randf_range(MIN_X, MAX_X), randf_range(MIN_Y, MAX_Y))
	override = false
	%trail.visible = false
	set_freeze_enabled(true)
	is_shot = false
	if allow_input == false:
		allow_input = true
	meter.modulate.a = 1
	Scoreboard.shot_1.emit()
	
func _on_sound_trigger_body_entered(body):
	print(body.name)
	if (body.name == "Basketball2"):
		Scoreboard.shot_made_1 = true
		print("hello")
		$Timer.start()
