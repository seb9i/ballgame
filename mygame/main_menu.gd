extends Control
@onready var start_button = $MarginContainer/HBoxContainer/VBoxContainer/Button1 as Button
@onready var options_button = $MarginContainer/HBoxContainer/VBoxContainer/Button2 as Button
@export var start_level = preload("res://Main.tscn")

func _ready():
	start_button.button_down.connect(on_button_down)
	
func on_button_down() -> void:
	get_tree().change_scene_to_packed(start_level)
