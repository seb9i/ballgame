extends Control
@onready var meter = $TextureProgressBar
var speed = 0.6
func _process(delta):
	if Input.is_action_pressed("Left"):
		if (meter.value == 100 or (meter.value == 0 and speed < 0)):
			speed *= -1
			
		meter.value += speed
