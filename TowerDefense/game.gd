extends Node2D

@export var game_stats: GameStats

@onready var coins_label: Label = $Coins/Label
@onready var health_label: Label = $Health/Label

@onready var path_2d: Path2D = $Path2D
@onready var slime_spawn_timer: Timer = $SlimeSpawnTimer
@onready var orc_spawn_timer: Timer = $OrcSpawnTimer

const SLIME = preload("res://enemies/slime.tscn")
const ORC = preload("res://enemies/orc.tscn")

var slime_spawns: int = 0
var orc_spawns: int = 0


func _ready() -> void:
	Events.request_upgrade.connect(_on_request_upgrade)
	Events.enemy_passed.connect(_on_enemy_passed)
	Events.enemy_died.connect(_on_enemy_died)
	
	coins_label.text = str(game_stats.coins)
	health_label.text = str(game_stats.health)
	
	slime_spawn_timer.timeout.connect(spawn_slime)
	orc_spawn_timer.timeout.connect(spawn_orc)
	

func _on_request_upgrade(cost: int, upgrade_function: Callable):
	if game_stats.coins < cost: return
	
	game_stats.coins -= cost
	coins_label.text = str(game_stats.coins)
	
	upgrade_function.call()


func _on_enemy_passed(dmg: int):
	game_stats.health -= dmg
	
	health_label.text = str(max(game_stats.health, 0))
	
	if game_stats.health <= 0:
		get_tree().change_scene_to_packed(preload("res://game_over.tscn"))


func _on_enemy_died(coins: int):
	game_stats.coins += coins
	coins_label.text = str(game_stats.coins)


func spawn_slime():
	var slime = SLIME.instantiate()
	path_2d.add_child(slime)
	
	slime_spawns += 1
	slime_spawn_timer.start(max(0.4, 2.2 - slime_spawns / 70))


func spawn_orc():
	var orc = ORC.instantiate()
	path_2d.add_child(orc)
	
	orc_spawns += 1
	orc_spawn_timer.start(max(1.2, 5.5 - orc_spawns / 100))
