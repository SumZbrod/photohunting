class_name NaturalClass extends Area2D
@onready var sprite: Sprite2D = $Sprite2D

var is_shaking := false
var speed := 0.
@export var max_speed := 2.
var min_speed := .1
var acceleration := 2

func _ready() -> void:
	connect("area_entered", set_is_shaking)
	connect("area_exited", set_is_not_shaking)

func _physics_process(delta: float) -> void:
	maintain_shaking(delta)

func set_is_shaking(area: Area2D) -> void:
	if area is WindClass:
		is_shaking = true

func set_is_not_shaking(area: Area2D) -> void:
	if area is WindClass:
		is_shaking = false

func maintain_shaking(delta) -> void:
	speed += delta*acceleration * (1 if is_shaking else -1)
	speed = clamp(speed, min_speed, max_speed)
	sprite.material.set_shader_parameter("speed", speed)
