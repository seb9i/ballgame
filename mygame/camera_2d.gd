extends Camera2D
@export var randomStrength: float = 30.0
@export var shakeFade: float = 5.0
var rng = RandomNumberGenerator.new()
var shake_strength: float = 0.0
var enabled_shake = false
func apply_shake(strength = 30):
	shake_strength = strength
func _process(delta):
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shakeFade *  delta)
		offset = randomOffset()
func randomOffset() -> Vector2:
	return Vector2(randf_range(-shake_strength, shake_strength), randf_range(-shake_strength, shake_strength))

func activateDefense():
	enabled_shake = !enabled_shake

	
	
