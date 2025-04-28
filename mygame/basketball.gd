extends RigidBody2D


@onready var bounce = $bounce
@onready var rimpos = get_parent().get_node("Rim")
# Markers for rim shots
@onready var collision_shape = rimpos.get_node("Medium")
@onready var collision_shape2 = rimpos.get_node("Short")
@onready var collision_shape3 = rimpos.get_node("CollisionShape2D")
@onready var collision_shape4 = rimpos.get_node("Long")
func _physics_process(delta):
	
	

	var shape_world_pos = collision_shape.global_position 

	var ball = get_parent().get_node("Basketball")

	# Close Shot
	if Input.is_action_just_pressed("Left"):
		if (collision_shape3.global_position.distance_to(ball.get_node("CollisionShape2D").global_position) < 700):
			toss_ball_parabola(ball, collision_shape2.global_position, 70)
			print("hello")
		# Far Shot	
		elif (collision_shape3.global_position.distance_to(ball.get_node("CollisionShape2D").global_position) > 1100):
			print(collision_shape3.global_position.distance_to(ball.get_node("CollisionShape2D").global_position))
			toss_ball_parabola(ball, collision_shape4.global_position, 50)
			print("far")
		# Medium Shot	
		else:
			print(collision_shape3.global_position.distance_to(ball.get_node("CollisionShape2D").global_position))
			toss_ball_parabola(ball, shape_world_pos, 65)
			print("medium")


	if Input.is_action_just_pressed("Right"):
		linear_velocity = Vector2(300, -650)

func toss_ball_parabola(ball: RigidBody2D, target_pos: Vector2, launch_angle_deg: float):
	var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	var collision_shape = ball.get_node("CollisionShape2D")

	var displacement = target_pos - collision_shape.global_position
	var dx = displacement.x 
	var dy = displacement.y
	
	var angle_rad = deg_to_rad(launch_angle_deg)
	var cos_angle = cos(angle_rad)
	var sin_angle = sin(angle_rad)
	
	if abs(cos_angle) < 0.001:
		print("Launch angle too steep!")
		return
	
	var speed_squared = (gravity * dx * dx) / (2 * (dy - dx * tan(angle_rad)) * cos_angle * cos_angle)
	
	if speed_squared < 0:
		print("No valid solution — target too far or too high for this angle!")
		return
	
	var launch_speed = sqrt(speed_squared)
	
	var vx = launch_speed * cos_angle
	var vy = launch_speed * sin_angle
	
	ball.linear_velocity = Vector2(-vx, -vy)
	
func transfer_ball_random():
	var x = randi_range(200, 1000)

# Collision Sound Effects
func _on_body_entered(body: Node) -> void:
	
	if (abs(self.linear_velocity.x) > 50 or abs(self.linear_velocity.y) > 50):
		if (body.name == "Rim"):
			$"../RIM".play()
		else:
			$"../bounce".play()
		


func _on_bounce_finished() -> void:
	pass # Replace with function body.


func _on_rim_finished() -> void:
	pass # Replace with function body.
