class_name UpgradeComponent
extends Node

@export var tower: Tower
@export var upgraded_tower: PackedScene
@export var cost: int

@export var button: Button
@export var hover_area: Area2D


func _ready() -> void:
	button.text = "Upgrade (" + str(cost) + ")"
	
	button.visible = false
	
	hover_area.mouse_entered.connect(func():
		button.visible = true
	)
	
	hover_area.mouse_exited.connect(func():
		button.visible = false
	)
	
	button.pressed.connect(func():
		Events.request_upgrade.emit(cost, upgrade)
	)


func upgrade():
	var new_tower = upgraded_tower.instantiate()
	
	new_tower.global_position = tower.global_position
	
	tower.get_parent().add_child(new_tower)
	tower.queue_free()
