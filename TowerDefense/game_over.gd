extends Control

@onready var button: Button = $Button


func _ready() -> void:
	button.pressed.connect(func(): get_tree().quit())

