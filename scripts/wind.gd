class_name WindClass extends FloatingClass
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play('spin')

func _physics_process(delta: float) -> void:
	maintai_velocity(delta, Vector2(1, 2))
	
