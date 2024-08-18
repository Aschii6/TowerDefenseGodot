class_name ProjectileMoveComponent
extends Node

@export var actor: Projectile

@export var speed: int = 150
@export var projectile_range: int = 300

var travelled_distance: float = 0


func _process(delta: float) -> void:
	var direction = Vector2.UP.rotated(actor.rotation)
	
	actor.global_position += direction * speed * delta
	
	travelled_distance += speed * delta
	
	if travelled_distance > projectile_range:
		actor.queue_free()
