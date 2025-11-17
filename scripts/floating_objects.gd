class_name FloatingClass extends Area2D

var velocity := Vector2.ZERO
var acceleration := .01
var speed := .1

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var shape = collision_shape_2d.shape.get_rect().size * collision_shape_2d.scale * 1.5
var pos := Vector2.ZERO

func maintai_velocity(delta, y_pos=null):
	if !y_pos:
		velocity += (Vector2(randf(), randf())*2-Vector2.ONE)* acceleration
		velocity = Vector2(.5, 1) * speed
		velocity = velocity.normalized() * speed
	else:
		velocity = Vector2(.5, 1) * speed
	pos += velocity*delta
	pos = pos.posmod(1)
	var new_global_pos =  (get_viewport_rect().size+2*shape) * pos - shape
	if y_pos:
		new_global_pos.y = y_pos
	global_position = new_global_pos
