extends Node

signal request_upgrade(cost: int, upgrade_function: Callable)

signal enemy_passed(dmg: int)
signal enemy_died(coins: int)

func _ready() -> void:
	pass
