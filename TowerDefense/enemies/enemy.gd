class_name Enemy
extends PathFollow2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var stats_component: StatsComponent = $StatsComponent
@onready var move_component: MoveComponent = $MoveComponent
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent

var is_dead: bool = false

func _ready() -> void:
	rotation = 0
	rotates = false
	
	visible_on_screen_notifier_2d.screen_exited.connect(func():
		Events.enemy_passed.emit(stats_component.dmg)
		queue_free()
	)
	
	stats_component.no_health.connect(func():
		Events.enemy_died.emit(stats_component.dmg)
		is_dead = true
		remove_child(move_component)
		hurtbox_component.set_collision_layer_value(1, false)
		animated_sprite_2d.play("death")
		animated_sprite_2d.animation_finished.connect(queue_free)
	)

