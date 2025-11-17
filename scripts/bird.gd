class_name BirdClass extends AnimatedSprite2D

var frame_score := [
	# fly	# stand	# spatial
	1, 		2, 		3, 		# crown 
	2, 		3, 		4, 		# seagull
	3, 		4, 		5, 		# magpie 
]

func calc_score():
	return frame_score[frame]
