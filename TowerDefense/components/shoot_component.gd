class_name ShootComponent
extends Node

@export var tower: Tower
@export var shoot_area: Area2D
@export var shoot_cd: float
@export var projectile: PackedScene
@export var shoot_marker: Marker2D

func _ready() -> void:
	var shoot_timer = Timer.new()
	
	shoot_timer.wait_time = shoot_cd
	shoot_timer.timeout.connect(shoot)
	shoot_timer.autostart = true
	
	tower.add_child.call_deferred(shoot_timer)


func shoot():
	var enemy_hurtboxes_in_range = shoot_area.get_overlapping_areas()
	
	if enemy_hurtboxes_in_range.size() == 0: return
	
	enemy_hurtboxes_in_range.sort_custom(func(a, b): 
		var p1 = a.get_parent()
		var p2 = b.get_parent()
		
		if p1 is PathFollow2D and p2 is PathFollow2D:
			return p1.progress_ratio > p2.progress_ratio
		else:
			return false
	)
	
	var target_enemy: Enemy = enemy_hurtboxes_in_range[0].get_parent()
	
	var new_projectile: Projectile = projectile.instantiate()
	tower.add_child(new_projectile)
	
	new_projectile.global_position = shoot_marker.global_position
	
	var direction = shoot_marker.global_position.direction_to(target_enemy.global_position)
	
	new_projectile.rotation = direction.angle() + 1.35
