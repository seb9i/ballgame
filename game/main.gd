extends Node2D

@onready var ambience = $ambience
@onready var swish = $net

func _ready():
	ambience.play()


func _on_ambience_finished() -> void:
	pass # Replace with function body.


func _on_area_2d_body_entered(body) -> void:
	if (body.name == "Basketball"):
		swish.play()
		
