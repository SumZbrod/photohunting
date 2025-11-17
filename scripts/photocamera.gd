class_name PhotoCamera extends Control

@onready var hud: NinePatchRect = $hud
@onready var lens = $lens
@onready var albom: NinePatchRect = $albom
@export var level_screen: NinePatchRect
@onready var lens_area: Area2D = $"../SubViewport/Level/Lens"
@onready var score_label: Label = $ScoreLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var photo_counter_label: Label = $PhotoCounterLabel

var includet_objects := {}
var lens_size = Vector2(494, 480) # не успел разобраться как из Control/Layout доставать Size поэтому хардкод
var albom_size = Vector2(131, 133)
var photo_counter := 0
var photo_limit := 10

func _ready() -> void:
	lens_area.connect("area_entered", _on_area_entered)
	lens_area.connect("area_exited", _on_area_exited)

func _process(_delta: float) -> void:
	if visible:
		maintain_input()
	
func maintain_input():
	if Input.is_action_just_pressed('interact'):
		make_photo()

func scale_ui():
	var rescal_value = get_viewport_rect().size / Vector2(1920, 1080)
	lens_area.scale *= rescal_value

func make_photo():
	if animation_player.is_playing():
		return
	if photo_counter >= photo_limit:
		animation_player.play("reject")
	else:
		photo_counter += 1
		animation_player.play("flash")
		update_albome()
		calc_score()
	
func update_albome():
	var region: Rect2i = Rect2i(global_position + get_viewport_rect().size * .5 -lens_size/2, lens_size)
	var img = level_screen.texture.get_image().get_region(region)
	var tex = ImageTexture.create_from_image(img)
	albom.set_texture(tex)

func calc_score():
	var photo_score = 1
	for obj in includet_objects.values():
		photo_score += obj.calc_score()
	score_label.text = "Score: %d" % photo_score 
	photo_counter_label.text = "%d / %d" % [photo_counter, photo_limit]
	
func _on_area_entered(area: Area2D) -> void:
	if area.has_method("calc_score"):
		var area_id = area.get_rid()
		includet_objects[area_id] = area

func _on_area_exited(area: Area2D) -> void:
	var area_id = area.get_rid()
	if area_id in includet_objects:
		includet_objects.erase(area_id)

func make_vidible():
	if animation_player.is_playing():
		return
	if !visible:
		animation_player.play("show_up")
	else:
		animation_player.play_backwards("show_up")
