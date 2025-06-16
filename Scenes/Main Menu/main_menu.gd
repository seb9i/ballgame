extends Control
@onready var start_button = $MarginContainer/HBoxContainer/VBoxContainer/Button1 as Button
@onready var multiplayer_button = $MarginContainer/HBoxContainer/VBoxContainer/Button2 as Button
@export var start_level = preload("res://Scenes/Level Select/control.tscn")

func _ready():
	start_button.button_down.connect(on_button_down)
	multiplayer_button.button_down.connect(on_button_down_2)
	
func on_button_down() -> void:
	get_tree().change_scene_to_packed(start_level)

func on_button_down_2():
	get_tree().change_scene_to_file("res://Scenes/Local Multiplayer/control.tscn")
