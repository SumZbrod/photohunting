class_name PhotoCamera extends Control

@onready var hud: NinePatchRect = $hud
@onready var lens = $lens
@onready var albom: NinePatchRect = $albom
@export var level_screen: NinePatchRect
@onready var lens_area: Area2D = $"../SubViewport/Level/Lens"

var includet_objects := {}
var lens_size = Vector2(494, 480) # не успел разобраться как из Control/Layout доставать Size поэтому хардкод
var albom_size = Vector2(131, 133)

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
	update_albome()
	calc_score()
	
func update_albome():
	var region: Rect2i = Rect2i(global_position + get_viewport_rect().size * .5 -lens_size/2, lens_size)
	var img = level_screen.texture.get_image().get_region(region)
	var tex = ImageTexture.create_from_image(img)
	var albom_scale = albom_size / tex.get_size()
	albom.set_texture(tex)

func calc_score():
	var photo_score = 0
	for obj in includet_objects.values():
		photo_score += obj.calc_score
	print("Score for photo is: ", photo_score)
	
func _on_area_entered(area: Area2D) -> void:
	if area.has_method("calc_score"):
		var area_id = area.get_rid()
		includet_objects[area_id] = area

func _on_area_exited(area: Area2D) -> void:
	var area_id = area.get_rid()
	if area_id in includet_objects:
		includet_objects.erase(area_id)
