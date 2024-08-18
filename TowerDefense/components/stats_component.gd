class_name StatsComponent
extends Node

signal no_health

@export var health: int = 1:
	set(value):
		health = value
		if health <= 0:
			no_health.emit()

@export var dmg: int = 1
