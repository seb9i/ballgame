extends RigidBody2D

@onready var rimpos = get_parent().get_node("Rim")
@onready var projectile_caller = $projectile

func _physics_process(delta):
	var ball = get_parent().get_node("RigidBody2D")
	if Input.is_action_just_pressed("Right"):
		var destination = get_global_mouse_position()
		print(projectile_caller.projectiles)
		print(projectile_caller.request_projectile(0, ball.global_position, rimpos.global_position))
