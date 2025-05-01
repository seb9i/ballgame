extends Node2D

@onready var ambience = $ambience
@onready var swish = $net

var resource = load("res://Dialogue/tutorial.dialogue")
var dialogue_line = await 	DialogueManager.get_next_dialogue_line(resource, "start")
func _ready():
	dialogue_line = await DialogueManager.get_next_dialogue_line(resource, dialogue_line.next_id)
	ambience.play()
	


func _on_ambience_finished() -> void:
	pass # Replace with function body.


func _on_area_2d_body_entered(body) -> void:
	if (body.name == "Basketball"):
		swish.play()
		
