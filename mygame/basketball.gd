extends RigidBody2D

var rng = RandomNumberGenerator.new()

@onready var rimpos = get_parent().get_node("Rim")
# Markers for rim shots
@onready var collision_shape = rimpos.get_node("Medium")
@onready var collision_shape2 = rimpos.get_node("Short")
@onready var collision_shape3 = rimpos.get_node("CollisionShape2D")
@onready var collision_shape4 = rimpos.get_node("Long")
@onready var camera : Camera2D = get_parent().get_node("Camera2D")
@onready var meter = get_parent().get_node("Control")
@onready var bar = meter.get_node("TextureProgressBar")
const RESET_LENGTH = 100
const RESET_WIDTH = 550
const MIN_X = 400
const MAX_X = 1200
const MIN_Y = 200
const MAX_Y = 600
var is_shot = false
var time = Time.get_unix_time_from_system()


func _unhandled_input(event) -> void:
	var ball = get_parent().get_node("Basketball")
	var shape_world_pos = collision_shape.global_position 

	if not is_shot:
		
		if Input.is_action_just_released("Shoot"):
			time = Time.get_unix_time_from_system()
			
			if (collision_shape3.global_position.distance_to(ball.get_node("CollisionShape2D").global_position) < 700):
				toss_ball_parabola(collision_shape2.global_position, 70, ball, bar.value)



			# Far Shot	
			elif (collision_shape3.global_position.distance_to(ball.get_node("CollisionShape2D").global_position) > 1100):

				toss_ball_parabola(collision_shape4.global_position, 60, ball, bar.value)

			# Medium Shot	
			else:
				toss_ball_parabola(shape_world_pos, 60, ball, bar.value)
			is_shot = true
			print(bar.value)
			bar.value = 0
			bar.visible = false
			
	
	
func _physics_process(delta):
	var ball = get_parent().get_node("Basketball")
	bar.global_position = ball.global_position
	if ball.global_position.y >= RESET_WIDTH and ball.global_position.x <= RESET_LENGTH:
		ball.global_position = Vector2(randf_range(MIN_X, MAX_X), randf_range(MIN_Y, MAX_Y))
		ball.set_freeze_enabled(true)
		ball.is_shot = false
	if is_shot:
		if Time.get_unix_time_from_system() - time > 3:
			ball.global_position = Vector2(randf_range(MIN_X, MAX_X), randf_range(MIN_Y, MAX_Y))
			ball.set_freeze_enabled(true)
			ball.is_shot = false
	pass

func toss_ball_parabola(target_pos: Vector2, launch_angle_deg: float, ball = get_parent().get_node("Basketball"), meter = 100):
	var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	var collision_shape = ball.get_node("CollisionShape2D")
	ball.set_freeze_enabled(false)

	var displacement = target_pos - collision_shape.global_position
	var dx = displacement.x 
	var dy = displacement.y
	
	var angle_rad = deg_to_rad(launch_angle_deg)
	var cos_angle = cos(angle_rad)
	var sin_angle = sin(angle_rad)
	
	if abs(cos_angle) < 0.001:
		return
	#
	var speed_squared = (gravity * dx * dx) / (2 * (dy - dx * tan(angle_rad)) * cos_angle * cos_angle)
	
	if speed_squared < 0:
		return
	
	var launch_speed = sqrt(speed_squared)
	
	if (meter > 90):
		meter = 100
	
	var vx = rng.randf_range((launch_speed * cos_angle) * (meter / 100), launch_speed * cos_angle )
	var vy = rng.randf_range((launch_speed * sin_angle) * (meter / 100), launch_speed * sin_angle )
	
	ball.linear_velocity = Vector2(-vx, -vy)
	return true


 
	
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
