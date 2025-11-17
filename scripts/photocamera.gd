class_name PhotoCamera extends Area2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var size = collision_shape_2d.scale
@onready var hud: Sprite2D = $Sprite2D



func scale_ui():
	hud.scale *= get_viewport_rect().size / Vector2(1920, 1080)
