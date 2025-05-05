extends Area2D
@onready var projectile_caller = $ProjectileCaller2D
									
func _process(_delta):
	if Input.is_action_just_pressed("Right"):
		var ball = get_parent().get_node("Area2D")

		var destination = get_global_mouse_position()
		print(projectile_caller.request_projectile(0, ball.global_position, destination))
