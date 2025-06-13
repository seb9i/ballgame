extends Control
@onready var meter = $TextureProgressBar
var speed = 2
var transparency = 0.02   
@onready var basketball = get_parent().get_node("Basketball")
func _process(delta):

	if not basketball.is_shot and basketball.allow_input:
		
		if Input.is_action_just_pressed("Shoot"):
			meter.visible = true
			$Timer.start()
			if (meter.value == 100 or (meter.value == 0 and speed < 0)):
				speed *= -1
				transparency *= -1 
				


		if Input.is_action_just_released("Shoot"):
			meter.value = 0
			meter.modulate.a = 1


func _on_timer_timeout():
	meter.value += speed
	meter.modulate.a -= transparency
	if (meter.value == 100 or meter.value == 0):
		speed *= -1
		transparency *= -1 
	$Timer.start()
