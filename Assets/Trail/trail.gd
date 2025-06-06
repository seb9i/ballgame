extends Line2D

var queue : Array
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var pos = _get_position()
	queue.push_front(pos)
	if (queue.size() > 35):
		queue.pop_back()
	clear_points()
	
	for point in queue:
		add_point(point)
		
func _get_position():
	return get_global_mouse_position()
	
