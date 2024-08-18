class_name Projectile
extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var projectile_move_component: ProjectileMoveComponent = $ProjectileMoveComponent
@onready var hitbox_component: HitboxComponent = $HitboxComponent
