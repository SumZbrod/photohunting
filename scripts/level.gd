extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var animation_names = ['crown', 'seagull', 'magpie']

func _process(_delta: float) -> void:
	make_bird()
	
func make_bird():
	if !animation_player.is_playing():
		var i = randi_range(0, 2)
		var animation_name = animation_names[i]
		animation_player.play(animation_name)
