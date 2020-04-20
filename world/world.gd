extends Node2D



func _ready():
	#$transition.play(true)
	$transition.black()

func open():
	$transition.play(false)
	
