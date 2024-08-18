extends Projectile

func _ready() -> void:
	hitbox_component.hit_hurtbox.connect(func(hurtbox: HurtboxComponent):
		queue_free()
	)
