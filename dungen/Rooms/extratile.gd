extends StaticBody2D


var tiles = [load("res://tiles/shitstump.png"),load("res://tiles/r_o_c_k.png")]
var num

class_name extra

func get_cass(): return "extra"

func _ready():
	randomize()
	num = int(rand_range(0,10))
	
	var t = int(rand_range(0,50))
	#print(t)
	if(t==0):
		if Level.biome == "forest":
			$Sprite.texture = tiles[0]
		else:
			$Sprite.texture = tiles[1]
	else: 
		$Sprite.texture = null
		queue_free()
	z_index = int(position.y)
		

func _on_extratile_body_entered(body):
	if body.get_class() == "extra":
		if num<body.num:
			queue_free()
