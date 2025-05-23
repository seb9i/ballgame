extends Node

var score = 0
signal shot
var shot_made: 
	set (new_value):
		shot_made = new_value
		shot.emit()
	get:
		return shot_made
		shot_made = false



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
