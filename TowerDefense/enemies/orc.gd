class_name Orc
extends Enemy

var last_pos: Vector2 = Vector2.ZERO

func _ready() -> void:
	super()


func _process(delta: float) -> void:
	if is_dead: return
	
	var current_pos: Vector2 = global_position
	
	var dif: Vector2 = current_pos - last_pos
	
	if dif.x < -delta * 5:
		animated_sprite_2d.play("walk_left")
	elif dif.x > delta * 5:
		animated_sprite_2d.play("walk_right")
	
	if dif.y < -delta * 5:
		animated_sprite_2d.play("walk_up")
	elif dif.y > delta * 5:
		animated_sprite_2d.play("walk_down")
	
	last_pos = current_pos
