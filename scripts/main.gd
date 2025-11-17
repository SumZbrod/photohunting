extends Node2D

var photocamera_min_pos: Vector2
var photocamera_max_pos: Vector2
var photocamera_max_speed := 15.
var photocamera_speed := 0.
var photocamera_acceleration := .5
@onready var photocamera: PhotoCamera = $Camera2D/Photocamera
@onready var bg: Sprite2D = $BG
@onready var camera_2d: Camera2D = $Camera2D

func _ready() -> void:
	var screen_center = get_viewport_rect().size * .5
	photocamera.global_position = screen_center
	photocamera.scale_ui()

func _process(_delta: float) -> void:
	maintain_input()

func _physics_process(_delta: float) -> void:
	maintain_move_camera()

func maintain_input():
	if Input.is_action_just_pressed('ui_text_indent'):
		photocamera.visible = !photocamera.visible
		

func maintain_move_camera() -> void:
	if !photocamera.visible:
		return
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if input_dir:
		if photocamera_speed < photocamera_max_speed:
			photocamera_speed += photocamera_acceleration
		photocamera_min_pos = 11*photocamera.size
		photocamera_min_pos.y = 0
		photocamera_max_pos = get_viewport_rect().size * 1. - photocamera_min_pos
		camera_2d.global_position += input_dir * photocamera_speed
		#camera_2d.global_position = camera_2d.global_position.clamp(photocamera_min_pos, photocamera_max_pos)
	elif photocamera_speed > 0:
		photocamera_speed = max(0, photocamera_speed-photocamera_acceleration)
