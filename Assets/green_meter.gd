extends Control
@onready var meter = $TextureProgressBar
var speed = 2
var transparency = 0.02  
var shoot_pressed = false 
@onready var basketball = get_parent()
func _process(delta):
	rotation = -get_parent().rotation
	if not basketball.is_shot and basketball.allow_input:
		
		if shoot_pressed:
			meter.visible = true
			$Timer.start()
			
				


		


func _on_timer_timeout():
	meter.value += speed
	meter.modulate.a -= transparency
	if (meter.value == 100 or meter.value == 0):
		speed *= -1
		transparency *= -1 
	$Timer.start()
