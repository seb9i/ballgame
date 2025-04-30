extends RigidBody2D


@onready var bounce = $bounce
@onready var rimpos = get_parent().get_node("Rim")
# Markers for rim shots
@onready var collision_shape = rimpos.get_node("Medium")
@onready var collision_shape2 = rimpos.get_node("Short")
@onready var collision_shape3 = rimpos.get_node("CollisionShape2D")
@onready var collision_shape4 = rimpos.get_node("Long")

const reset_length = 100
const reset_width = 550
const MIN_X = 400
const MAX_X = 1000
const MIN_Y = 400
const MAX_Y = 700
func _physics_process(delta):
	
	

	var shape_world_pos = collision_shape.global_position 

	var ball = get_parent().get_node("Basketball")

	if ball.global_position.y >= reset_width and ball.global_position.x <= reset_length:
		ball.global_position = Vector2(randf_range(MIN_X, MAX_X), randf_range(MIN_Y, MAX_Y))
		
		ball.set_freeze_enabled(true)
		

	# Close Shot
	if Input.is_action_just_pressed("Left"):
		ball.set_freeze_enabled(false)
		if (collision_shape3.global_position.distance_to(ball.get_node("CollisionShape2D").global_position) < 700):

			print(-find_launch_speed(ball, collision_shape2.global_position, 70) )
			print(-find_launch_speed(ball, collision_shape2.global_position, 70) * sin(70))
			ball.linear_velocity = Vector2(-find_launch_speed(ball, collision_shape2.global_position, 70) * cos(deg_to_rad(70)), -find_launch_speed(ball, collision_shape2.global_position, 70) * sin(deg_to_rad(70)))
			print("hello")
		# Far Shot	
		elif (collision_shape3.global_position.distance_to(ball.get_node("CollisionShape2D").global_position) > 1100):

			toss_ball_parabola(ball, collision_shape4.global_position, 60)
			print("far")
		# Medium Shot	
		else:

			toss_ball_parabola(ball, shape_world_pos, 60)
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
	#
	var speed_squared = (gravity * dx * dx) / (2 * (dy - dx * tan(angle_rad)) * cos_angle * cos_angle)
	
	if speed_squared < 0:
		print("No valid solution — target too far or too high for this angle!")
		return
	
	var launch_speed = sqrt(speed_squared)
	
	var vx = launch_speed * cos_angle
	var vy = launch_speed * sin_angle
	
	ball.linear_velocity = Vector2(-vx, -vy)
	

func find_launch_speed(ball: RigidBody2D, target_pos: Vector2, angle: float):
	var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	

	var displacement = target_pos + ball.global_position
	var dx = abs(displacement.x)
	
	var dy = sqrt(abs(displacement.y))

	

	print("Displacement" + str(dx))
	print("Top: " + str(dx * 980))
	print("Bottom: " + str(sin(deg_to_rad(2 * angle))))



	var bottom = sqrt((sin((deg_to_rad(2 * angle)))))
	print("Whole:" + str((sqrt((dx * 9.80) / (sin(deg_to_rad(2 * angle)))))))

	return (sqrt((dx * 9.80) / (sin(deg_to_rad(2 * angle)))))	
	
	
	
	
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
