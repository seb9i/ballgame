extends "res://Assets/Trail/trail.gd"

@onready var shape = get_parent().get_node("CollisionShape2D")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function 	
	
func _get_position():
	var x_value = shape.global_position.x + 30
	var y_value = shape.global_position.y - 5
	var vector = Vector2(x_value, y_value)
	return vector
