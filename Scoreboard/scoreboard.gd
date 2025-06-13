extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func show_score():
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(480, -203), 2).from(Vector2(480, -350))
	Scoreboard.score = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
