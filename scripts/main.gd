extends Control

var photocamera_min_pos: Vector2
var photocamera_max_pos: Vector2
var photocamera_max_speed := 15.
var photocamera_speed := 0.
var photocamera_acceleration := .5
@onready var photocamera: PhotoCamera = $Photocamera
@onready var lens_area: Area2D = $"SubViewport/Level/Lens"

func _ready() -> void:
	var screen_center = get_viewport_rect().size * .5
	lens_area.global_position = screen_center
	photocamera.scale_ui()

func _process(_delta: float) -> void:
	maintain_input()

func _physics_process(_delta: float) -> void:
	maintain_move_camera()

func maintain_input():
	if Input.is_action_just_pressed('ui_text_indent'):
		photocamera.make_vidible()

func maintain_move_camera() -> void:
	if !photocamera.visible:
		return
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if input_dir:
		if photocamera_speed < photocamera_max_speed:
			photocamera_speed += photocamera_acceleration
		input_dir *= photocamera_speed
		photocamera.global_position += input_dir
		lens_area.global_position += input_dir
	elif photocamera_speed > 0:
		photocamera_speed = max(0, photocamera_speed-photocamera_acceleration)
