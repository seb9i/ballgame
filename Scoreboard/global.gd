extends Node

var score = 0
var score_1 = 0
var player_turns = 3
var ai_turns = 3
signal shot
signal shot_1
var shot_made: 
	set (new_value):
		if (new_value == true):
			Scoreboard.score += 1
		shot_made = new_value
	get:
		return shot_made
var shot_made_1: 
	set (new_value):
		if (new_value == true):
			Scoreboard.score_1 += 1
		shot_made_1 = new_value
	get:
		return shot_made_1 




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
