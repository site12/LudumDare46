extends Node2D



func _ready():
	#$transition.play(true)
	$transition.black()
	$music.play()

func open():
	$transition.play(false)
	
