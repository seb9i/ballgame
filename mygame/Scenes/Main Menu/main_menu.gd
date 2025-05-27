extends Control
@onready var start_button = $MarginContainer/HBoxContainer/VBoxContainer/Button1 as Button
@onready var options_button = $MarginContainer/HBoxContainer/VBoxContainer/Button2 as Button
@export var start_level = preload("res://Scenes/Tutorial/Main.tscn")

func _ready():
	start_button.button_down.connect(_on_button_1_button_down)
	


func _on_button_1_button_down() -> void:
	get_tree().change_scene_to_packed(start_level)
