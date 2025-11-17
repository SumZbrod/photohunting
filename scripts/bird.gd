class_name BirdClass extends AnimatedSprite2D

enum Frames {FLY, STAND, SPACIAL}

func set_flying():
	frame = Frames.FLY
	
func set_stand():
	frame = Frames.STAND
	
func set_spatial():
	if frame == Frames.STAND:
		frame = Frames.SPACIAL
		
