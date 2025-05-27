extends Node

var score = 0
signal shot
var shot_made: 
	set (new_value):
		if (new_value == true):
			Scoreboard.score += 1
		shot_made = new_value
	get:
		return shot_made




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
