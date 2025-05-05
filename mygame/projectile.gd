extends ProjectileOnCurve2D
@onready var root = get_parent()

func _physics_process(delta):
	# 1) run all the built-in arc / gravity motion:
	super._physics_process(delta)
	
	# 2) then sync your real projectile root to follow:
	var parent = get_parent()
	parent.position = position
	parent.rotation = rotation
	parent.scale = scale
	
