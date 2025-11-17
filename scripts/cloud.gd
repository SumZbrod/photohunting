class_name CloudClass extends FloatingClass

var y_pos

func _ready() -> void:
	y_pos = global_position.y 

func _physics_process(delta: float) -> void:
	maintai_velocity(delta, Vector2(1, -.3))
