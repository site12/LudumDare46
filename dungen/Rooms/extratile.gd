extends Node2D


var tiles = [load("res://tiles/shitstump.png")]

func _ready():
	
	randomize()
	var t = int(rand_range(0,25))
	print(t)
	if(t==0):
		$Sprite.texture = tiles[t]
	else: 
		$Sprite.texture = null
		$CollisionShape2D.queue_free()
	z_index = int(position.y)
		

