class_name FloatingClass extends Area2D

var velocity := Vector2.ZERO
var acceleration := .01
@export var speed := .1

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var shape = collision_shape_2d.shape.get_rect().size * collision_shape_2d.scale * 1.5
var pos := Vector2.ZERO

func maintai_velocity(delta, new_velocity=null):
	if !new_velocity:
		velocity += (Vector2(randf(), randf())*2-Vector2.ONE)* acceleration
		velocity = velocity.normalized() * speed
	else:
		velocity = new_velocity * speed
	pos += velocity*delta
	pos = pos.posmod(1)
	var new_global_pos =  (get_viewport_rect().size+2*shape) * pos - shape
	global_position = new_global_pos
