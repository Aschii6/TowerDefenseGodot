class_name MoveComponent
extends Node

@export var actor: Enemy
@export var speed: float = 1


func _process(delta: float) -> void:
	actor.progress_ratio += 0.01 * speed * delta
