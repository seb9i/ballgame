extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	me()

func me():
	while true:
		var ai_shot = randf_range($Basketball2.ai_percentages(), 100)
		if ai_shot > 80:

			$Basketball2.toss_ball_parabola($Basketball2.collision_shape2.global_position, 70, $Basketball2)
		else:

			$Basketball2.toss_ball_parabola($Basketball2.collision_shape2.global_position, 70, $Basketball2, ai_shot)	
		await Scoreboard.shot_made

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
