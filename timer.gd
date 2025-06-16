extends Node2D
signal finished

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func show_score(x = 500):
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(x, -203), 4).from(Vector2(x, -350))
	Scoreboard.score = 0

func set_time(x):
	$Timer.wait_time = x
func start_time():
	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.text = str("%.2f" % $Timer.time_left)



func _on_timer_timeout():
	finished.emit()
