extends Node2D



func _ready():
	#$transition.play(true)
	$transition.black()
	$music.play()
	if Level.biome == 'cave':
		VisualServer.set_default_clear_color(Color("#302f39"))
	if Level.biome == 'forest':
		VisualServer.set_default_clear_color(Color("#dd401a"))
	if Level.biome == 'hell':
		VisualServer.set_default_clear_color(Color("8f0030"))

func open():
	$transition.play(false)
	
