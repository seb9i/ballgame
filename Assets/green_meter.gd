extends Control
@onready var meter = $TextureProgressBar
var speed = 0.6
@onready var basketball = get_parent().get_node("Basketball")
func _process(delta):
	if not basketball.is_shot and basketball.allow_input:
		
		if Input.is_action_pressed("Shoot"):
			meter.visible = true
			if (meter.value == 100 or (meter.value == 0 and speed < 0)):
				speed *= -1
				
			meter.value += speed
		if Input.is_action_just_released("Shoot"):
			meter.value = 0
